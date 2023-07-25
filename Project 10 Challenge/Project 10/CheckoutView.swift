//
//  CheckoutView.swift
//  Project 10
//
//  Created by Pedro Pablo on 23/07/23.
//

import SwiftUI

struct CheckoutView: View {
//    @ObservedObject var order: Order
    @ObservedObject var newOrder: NewOrder
    @State private var confirmationMessage = ""
    @State private var errorURLMessage = ""
    @State private var showingConfirmation = false
    @State private var showingErrorRequest = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL (string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                Text("Your total is \(newOrder.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
            .alert("Error URL request", isPresented: $showingErrorRequest) {
                Button("Ok") {}
            } message: {
                Text(errorURLMessage)
            }
        }
        .navigationTitle("Check-out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("Ok") {}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(newOrder.order) else {
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decoded = try JSONDecoder().decode(NewOrder.Order.self, from: data)
            confirmationMessage = "Your order for \(decoded.quantity)x \(NewOrder.Order.types[decoded.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            showingErrorRequest = true
            errorURLMessage = "Checkout failed: \(error)"
            print(error)
        }
        
    }
    
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(newOrder: NewOrder())
    }
}

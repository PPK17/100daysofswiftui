//
//  ContentView.swift
//  Project 10
//
//  Created by Pedro Pablo on 21/07/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var newOrder = NewOrder()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select yout cake type", selection: $newOrder.order.type) {
                        ForEach(NewOrder.Order.types.indices) {
                            Text(NewOrder.Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(newOrder.order.quantity)", value: $newOrder.order.quantity, in: 3...20)
                    
                    Section {
                        Toggle("Any special requests?", isOn: $newOrder.order.specialRequestEnabled.animation())
                        
                        if newOrder.order.specialRequestEnabled {
                            Toggle("Add extra frosting", isOn: $newOrder.order.extraFrosting)
                            Toggle("Add extra sprinkles", isOn: $newOrder.order.addSprinkles)
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            AddressView(newOrder: newOrder)
                        } label: {
                            Text("Delivery details")
                        }
                    }
                    
                }
            }
        }
        .navigationTitle("Cupcake Corner")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/**
 
 // DISABLE FORM
 
 struct ContentView: View {
     @State private var username = ""
     @State private var email = ""
     
     var body: some View {
         Form {
             Section {
                 TextField("Username", text: $username)
                 TextField("Email", text: $email)
             }
             Section {
                 Button("Create account") {
                     print("Creating account...")
                 }
             }
 //            .disabled(username.isEmpty || email.isEmpty)
             .disabled(disableForm)
         }
     }
     
     var disableForm: Bool {
         username.count < 5 || email.count < 5
     }
     
 }
 
 
 // ASYNC IMAGE
 
 
 struct ContentView: View {
     
     var body: some View {
         //GOOD IMAGE
         let str_url = "https://static.wikia.nocookie.net/doblaje/images/5/5b/SMAgain.jpg/revision/latest?cb=20220720003409&path-prefix=es"
         AsyncImage(url: URL(string: str_url)) { image in
             image
                 .resizable()
                 .scaledToFit()
         } placeholder: {
             ProgressView()
         }
         .frame(width: 300, height: 300)
         
         //BAD URL
         let another_url = "https://hws.dev/img/bad.png"
         AsyncImage(url: URL(string: another_url)) { phase in
             if let image = phase.image {
                 image
                     .resizable()
                     .scaledToFit()
             } else if phase.error != nil {
                 Text("There was an error loading the image.")
             } else {
                 ProgressView()
             }
         }
         .frame(width: 300, height: 300)
         
     }
     
 }
 
 
 // FETCH DATA FROM URL
 
 struct Response: Codable {
     var results: [Result]
 }


 struct Result: Codable {
     var trackId: Int
     var trackName: String
     var collectionName: String
 }


 struct ContentView: View {
     @State private var results = [Result]()
     
     var body: some View {
         List(results, id: \.trackId) { item in
             VStack(alignment: .leading) {
                 Text(item.trackName)
                     .font(.headline)
                 Text(item.collectionName)
             }
         }
         .task {
             await loadData()
         }
     }
     
     func loadData() async {
         guard let url = URL(string: "https://itunes.apple.com/search?term=juanes&entity=song") else {
             var _ = print("Invalid URL")
             return
         }
         
         do {
             //(data, metadata)
             let (data, _) = try await URLSession.shared.data(from: url)
             if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                 results = decodedResponse.results
             }
         } catch {
             print("Invalid data")
         }
         
     }
     
 }
 
 
 // ENCODE PUBLISHED DATA
 
 class User: ObservableObject, Codable {
     enum CodingKeys: CodingKey {
         case name
     }
     
     @Published var name = "Pedro Pablo"
     
     required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         name = try container.decode(String.self, forKey: .name)
     }
     
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(name, forKey: .name)
     }
     
 }
 
 
 
 */

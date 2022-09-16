//
//  ContentView.swift
//  Project 7
//
//  Created by Pedro Pablo on 22/08/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    let types = ["Personal", "Business"]
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(types, id: \.self) { type in
                    Section(type) {
                        ForEach(expenses.items) { item in
                            if type == item.type {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name).font(.headline)
                                        Text(item.type)
                                    }
                                    Spacer()
                                    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "PEN"))
                                        .foregroundColor(setColorAmount(amount: item.amount))
                                }
                            } else {}
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func setColorAmount(amount: Double) -> Color? {
        var selectedColor: Color? = nil
        switch amount {
        case 0...10:
            selectedColor = Color.green
        case 11...100:
            selectedColor = Color.yellow
        case 100...:
            selectedColor = Color.red
        default:
            selectedColor = nil
        }
        return selectedColor
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/**
 
 $$$ Guardar data compleja con json $$$$$
 
 struct User: Codable {
     let firstName: String
     let lastName: String
 }

 struct ContentView: View {
     @State private var user = User(firstName: "Taylor", lastName: "Swift")
     
     var body: some View {
         Button("Save user") {
             let encoder = JSONEncoder()
             if let data = try? encoder.encode(user) {
                 UserDefaults.standard.set(data, forKey: "UserData")
             }
         }
         
     }
     
 }
 
 
 
 $$$$$$ Guardar data localmente $$$$$$$
 
 struct ContentView: View {
 //    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
 //
 //    var body: some View {
 //        Button("Tap count: \(tapCount)") {
 //            tapCount += 1
 //            UserDefaults.standard.set(tapCount, forKey: "Tap")//Se guarda en el dispositivo
 //        }
 //
 //    }
     
     @AppStorage("tapCount") private var tapCount = 0
     
     var body: some View {
         Button("Tap count: \(tapCount)") {
             tapCount += 1
         }
         
     }
     
 }
 
 
 $$$$$$ Quitar items de una lista en ForEach $$$$$$$$
 
 struct ContentView: View {
     @State private var numbers = [Int]()
     @State private var currentNumber = 1
     
     var body: some View {
         NavigationView {
             VStack {
                 List {
                     ForEach(numbers, id: \.self) {
                         Text("Row \($0)")
                     }
                     .onDelete(perform: removeRows)
                 }
                 Button("Add Number") {
                     numbers.append(currentNumber)
                     currentNumber += 1
                 }
             }
             .navigationTitle("onDelete()")
             .toolbar() {
                 EditButton()
             }
         }
         
     }
     
     func removeRows(at offsets: IndexSet) {
         numbers.remove(atOffsets: offsets)
     }
     
     
 }
 
 
 $$$$$$$$ Mostrar data como un modal  .sheet / @Environment $$$$$$$$
 
 
 struct SecondView: View {
     @Environment(\.dismiss) var dismiss
     
     let name: String
     
     var body: some View {
         Text("Hello \(name)")
         Button("Dismiss") {
             dismiss()
         }
     }
 }

 struct ContentView: View {
     @State private var showingSheet = false
     
     var body: some View {
         Button("Show Sheet") {
             showingSheet.toggle()
         }
         .sheet(isPresented: $showingSheet) {
             SecondView(name: "PPK17")
         }
         
     }
 }
 
 
 
 $$$$$  @StateObject $$$$$$
 
 class User: ObservableObject {
     @Published var firstName = "Bilbo"
     @Published var lastName = "Baggins"
 }

 struct ContentView: View {
     @StateObject var user = User()//Usar al crear el objeto aqui
     //Si se quiere usar ese objeto en otro view, @ObservedObject
     
     var body: some View {
         VStack {
             Text("Your name is \(user.firstName) \(user.lastName)")
             TextField("First name", text: $user.firstName)
             TextField("Last name", text: $user.lastName)
         }
     }
 }
 
 
 
 */

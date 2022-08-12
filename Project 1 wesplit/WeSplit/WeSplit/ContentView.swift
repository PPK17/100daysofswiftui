//
//  ContentView.swift
//  WeSplit
//
//  Created by Pedro Pablo on 28/07/22.
// COMMAND + SHIFT + K = MOSTRAR/OCULTAR TECLADO DEL SIMULADOR

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPleople = 1
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 15, 20, 25]
    // Locale.current.currencyCode
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPleople + 1)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPleople) {
                        ForEach(1 ..< 20) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Amount of tip you want to leave")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }
            .navigationTitle("Split bill")
            .toolbar() {
                ToolbarItemGroup (placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}



/*
 
 
 struct ContentView: View {
     
     let students = ["Harry", "Hemorroide", "Colorado"]
     @State private var selectedStudent = "Harry"
     
     var body: some View {
         NavigationView {
             Form {
                 Picker("Select you student", selection: $selectedStudent) {
                     ForEach(students, id: \.self) { name in
                         Text(name)
                     }
                 }
             }
         }
     }
 }
 
 
 struct ContentView: View {
     @State private var name = ""
     // $name: Que muestre los cambios y permita modificar la variable ese mismo instante
     var body: some View {
         Form {
             TextField("Enter your name", text: $name)
             Text("Your name is \(name)")
         }
         
     }
 }
 
 struct ContentView: View {
     @State private var tapCount = 0
     
     var body: some View {
         
         Button("Tap Count: \(tapCount)") {
             tapCount += 1
         }
         
     }
 }
 
 
 NavigationView {
     Form {//Solo 10 children
         Section {
             Group {
                 Text("Hello, world!")
             }
         }
     }
     .navigationTitle("WeSplit")
     .navigationBarTitleDisplayMode(.large)
 }
 
 
 */






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

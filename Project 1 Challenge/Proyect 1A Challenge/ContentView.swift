//
//  ContentView.swift
//  Proyect 1A Challenge
//
//  Created by Pedro Pablo on 29/07/22.
//

import SwiftUI

enum focusText {
    case amount
}

struct ContentView: View {
    @State private var amount = 0.0
    @State private var selectedPeople = 1
    @State private var percentageTip = 0
    private let listTip = [0, 10, 20, 30, 40, 50]
    @FocusState private var focusField: focusText?
    
    private var grandTotal: Double {
        let amountTip = amount * Double(percentageTip) / 100.00
        let grandTotal = amount + amountTip
        return grandTotal
    }
    
    private var amountPerPeople: Double {
        let amountPerPeople = grandTotal / Double(selectedPeople + 1)
        return amountPerPeople
    }
    
    private var currencyFormat: FloatingPointFormatStyle<Double>.Currency {
        return FloatingPointFormatStyle<Double>.Currency.currency(code: "PEN")
//        return FloatingPointFormatStyle<Double>.Currency.currency(code: Locale.current.currencyCode ?? "PEN")
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Monto", value: $amount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($focusField, equals: .amount)
//                        .onAppear {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {  /// Anything over 0.5 seems to work
//                                self.focusField = .amount
//                            }
//                        }
//                        .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
//                            if let textField = obj.object as? UITextField {
//                                textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
//                            }
//                        }
                    Picker("Cantidad de personas", selection: $selectedPeople) {
                        ForEach(1..<21) {
                            let titlePeople = $0 == 1 ? "persona" : "personas"
                            Text("\($0) \(titlePeople)")
                        }
                    }
                }
                
                Section {
                    Picker("Propina", selection: $percentageTip) {
                        ForEach(listTip, id: \.self) {
                            Text("\($0)%")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Monto de propina que desea dejar")
                }
                
                Section {
                    Text(grandTotal, format: currencyFormat).foregroundColor(percentageTip == 0 ? .red : .primary)
                } header: {
                    Text("Monto total")
                }
                
                Section {
                    Text(amountPerPeople, format: currencyFormat)
                } header: {
                    Text("Monto por persona")
                }
                
            }.navigationTitle("Dividir cuenta")
        }.toolbar() {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    focusField = nil
                } label: {
                    Text("Hecho").font(.caption)
                }
            }
        }
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

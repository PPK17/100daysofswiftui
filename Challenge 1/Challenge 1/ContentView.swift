//
//  ContentView.swift
//  Challenge 1
//
//  Created by Pedro Pablo on 30/07/22.
//

import SwiftUI

enum focusText {
    case quantity
}

struct ContentView: View {
    
    let titleUnits: [String: String] = ["temp": "Temperatura", "length": "Distancia", "time": "Tiempo", "volume": "Volumen"]
    let listUnitIndex = ["temp", "length", "time", "volume"]
    let baseAmountQuantity = ["temp": 1.0, "length": 1.0, "time": 1.0, "volume": 1.0]
    let listTemperatures: [String: Double] = ["Celsius": 1.0, "Fahrenheit": 33.8, "Kelvin": 274.15] //Base celcius
    let temperatureTitles = ["Celsius", "Fahrenheit", "Kelvin"]
    let listLength: [String: Double] = ["Metros": 0.001, "Kilómetros": 1.0, "Pies": 3280.84, "Yardas": 1093.61, "Millas": 0.621371] //Base kilometros
    let lengthTitles = ["Metros", "Kilómetros", "Pies", "Yardas", "Millas"]
    let listTime: [String: Double] = ["Milisegundos": 60000.0, "Segundos": 60.0, "Minutos": 1.0, "Horas": 60.0, "Días": 1440.0] //Base minutos
    let timeTitles = ["Milisegundos", "Segundos", "Minutos", "Horas", "Días"]
    let listVolume: [String: Double] = ["Mililitros": 0.001, "Litros": 1.0, "Taza americana": 0.24, "Pinta": 0.473176, "Galones": 0.0] //Base litros
    let volumeTitles = ["Mililitros", "Litros", "Taza americana", "Pinta", "Galones"]
    let listUnits: [String: [String: Double]]
    let listUnitTitles: [String: [String]]
    
    @State private var selectedUnit = "temp"//Por defecto
    @State private var fromUnit = "Celsius"//Por defecto
    @State private var toUnit = "Fahrenheit"
    @State private var quantityToConvert: Double?
    @State private var indexFrom = 0//Cuando se vuelva a hacer la vista, seleccione lo anterior
    @State private var indexTo = 1//Cuando se vuelva a hacer la vista, seleccione lo anterior
    @FocusState private var focusQuantityToConvert: focusText?
    
    private var baseListUnit: [String] { //Seleccione el Array de De
        listUnitTitles[selectedUnit]!
    }
    
    private var finalListUnit: [String] { //Seleccione el Array de A
        listUnitTitles[selectedUnit]!
    }
    
    private var convertedQuantity: Double {
        var granTotal = 0.0
        //Convertir a base
        var unitBaseUnit = 1.0
        if let value = listUnits[selectedUnit]?[fromUnit] as? Double {
            unitBaseUnit = value
        }
        let unwrappedQuantity = quantityToConvert ?? 0
        if toUnit != "", let value = listUnits[selectedUnit]?[toUnit] as? Double {
            //Base convertida
            granTotal = (unwrappedQuantity * unitBaseUnit) / value
        }
        return granTotal
    }
    
    init() {
        listUnits = ["temp": listTemperatures, "length": listLength, "time": listTime, "volume": listVolume]
        listUnitTitles = ["temp": temperatureTitles, "length": lengthTitles, "time": timeTitles, "volume": volumeTitles]
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    Picker("Unidad", selection: $selectedUnit) {
                        ForEach(listUnitIndex, id: \.self) {
                            Text("\(titleUnits[$0]!)")
                        }
                    }.onChange(of: selectedUnit) {_ in
                        indexFrom = 0
                        indexTo = 1
                    }
                }
                
                Section {
                    Picker("De: ", selection: $fromUnit) {
                        ForEach(baseListUnit, id: \.self) {
                            Text("\($0)").id($0)
                        }
                        .onAppear() {
                            fromUnit = baseListUnit[indexFrom]
                        }
                    }.onChange(of: fromUnit) { //Cuando se vuelva a hacer la vista, seleccione lo anterior
                        indexFrom = baseListUnit.firstIndex(of: $0) ?? 0
                    }
                    Picker("A: ", selection: $toUnit) {
                        ForEach(finalListUnit, id: \.self) {
                            Text("\($0)")
                        }.onAppear() {
                            toUnit = finalListUnit[indexTo]
                        }
                    }.onChange(of: toUnit) {
                        indexTo = baseListUnit.firstIndex(of: $0) ?? 0
                    }
                } header: {
                    Text("\(titleUnits[selectedUnit]!)").bold().font(.headline)
                }
                
                Section {
                    TextField("Cantidad", value: $quantityToConvert, format: .number)
                        .focused($focusQuantityToConvert, equals: .quantity)
                        .keyboardType(.decimalPad).toolbar() {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button() {
                                    focusQuantityToConvert = nil
                                } label: {
                                    Text("Hecho")
                                }
                            }
                        }
                } header: {
                    Text("Cantidad a convertir").bold().font(.headline)
                }
                
                Section {
                    Text("\(convertedQuantity)")
                } header: {
                    Text("Resultado").bold().font(.headline)
                }
            }
            .navigationTitle("Conversiones")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  BetterRest
//
//  Created by Pedro Pablo on 9/08/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
//    @State private var wakeUp = Date.now
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var cofeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    // Text(dateFormatter.string(from: wakeUp))
    
    static var defaultWakeTime: Date {
        //Permite crear partes de una fecha a crear
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffe intake")
                        .font(.headline)
                    
                    Stepper(cofeeAmount == 1 ? "1 cup": "\(cofeeAmount) cups", value: $cofeeAmount, in: 1...20)
                }
                
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Ok") {}
            } message: {
                Text(alertMessage)
            }
        }
        
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(cofeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "There was a problem calculating your bedtime"
        }
        
        showingAlert = true
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/**
 
 $$$$$ Mostrar fecha en formato horas $$$$$$$
 
 struct ContentView: View {
     @State private var wakeUp = Date.now
     
     var body: some View {
         VStack {
             Text(Date.now, format: .dateTime.hour().minute()).padding()
         }
     }
     
 }
 
 $$$$$ Formato de fechas $$$$$$$$
 
 struct ContentView: View {
     @State private var wakeUp = Date.now
     
     var body: some View {
         VStack {
             Text(Date.now, format: .dateTime.hour().minute()).padding()
             Text(Date.now.formatted(date: .long, time: .shortened))
         }
     }
     
     func trivialExample() {
         let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
         let hour = components.hour ?? 0
         let minute = components.minute ?? 0
 //        var components  = DateComponents()
 //        components.hour = 8
 //        components.minute = 0
 //        let date = Calendar.current.date(from: components) ?? Date.now
     }
     
     
 }
 
 
 
 $$$$$$$ ELEGIR UNA FECHA $$$$$$$$
 
 struct ContentView: View {
     @State private var wakeUp = Date.now
     
     var body: some View {
         VStack {
             DatePicker("Enter date", selection: $wakeUp, in: Date.now..., displayedComponents: .date)
                 .labelsHidden()
             DatePicker("Enter date", selection: $wakeUp, displayedComponents: .date)
                 .labelsHidden()
             DatePicker("Enter date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                 .labelsHidden()
         }
     
     }
 }
 
 $$$$$$$  STEPPER: Input que permite aumentar o disminuir un valor con botones: (-) [] (+) $$$$$$$
 
 struct ContentView: View {
     @State private var sleepAmount = 8.0
     
     var body: some View {
         Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 0...12, step: 0.25)
     }
 }
 
 */

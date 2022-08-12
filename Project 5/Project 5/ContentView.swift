//
//  ContentView.swift
//  Project 5
//
//  Created by Pedro Pablo on 11/08/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("Hello World!")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/**
 
 $$$$$$$ UITextChecker $$$$$$$$
 
 struct ContentView: View {
     let people = ["Pedro", "Pablo", "Espinoza"]
     
     var body: some View {
         Text("JPA")
     }
     
     func test() {
         let word = "swift"
         let checker = UITextChecker()
         //Hacer un array de string empezando desde 0 hasta el utf16 de nuestra palabra
         let range = NSRange(location: 0, length: word.utf16.count)
         let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
         //Si se escribio correctamente es true, sino false
         let allGood = misspelledRange.location == NSNotFound
         
         
         let input = """
 a
 b
 c
 """
         // Devuelve un array de string al encontrar \n
         let letters = input.components(separatedBy: "\n")
         //Devuelve un String? aleatorio
         let letter = letters.randomElement()
         let trimmed = letter?.description.trimmingCharacters(in: .whitespacesAndNewlines)
     }
     
 }
 
 
 $$$$$$ BUNDLE $$$$$$$$$$$
 
 
 struct ContentView: View {
     let people = ["Pedro", "Pablo", "Espinoza"]
     
     var body: some View {
         Text("JPA")
     }
     
     func loadFile() {
         if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "text") {
             if let fileContents = try? String(contentsOf: fileURL) {
                 //Regular String
             }
         }
     }
     
 }
 
 
 $$$$$$$$$  LISTAS  $$$$$$$$$$
 
 
 struct ContentView: View {
     let people = ["Pedro", "Pablo", "Espinoza"]
     
     var body: some View {
         VStack {
             List {
                 Section("Section 1") {
                     Text("Static row 1")
                     Text("Static row 2")
                 }
                 Section("Section 2") {
                     ForEach(0..<4) {
                         Text("Hola \($0)")
                     }
                 }
                 Section("Section 3") {
                     Text("Static row 3")
                     Text("Static row 4")
                 }
                 
             }
             .listStyle(.grouped)
             List(0..<5) {
                 Text("Dynamic row \($0)")
             }
             List(people, id: \.self) {
                 Text("\($0)")
             }
         }
     }
 }
 
 
 */

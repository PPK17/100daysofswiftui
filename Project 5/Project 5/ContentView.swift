//
//  ContentView.swift
//  Project 5
//
//  Created by Pedro Pablo on 11/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    HStack {
                        TextField("Enter word", text: $newWord)
                            .autocapitalization(.none)
                        Spacer()
                        Text("Score: \(score)").font(.body.bold())
                    }
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar() {// Challenge 2
                Button("New word") {
                    score = 0
                    startGame()
                }
            }
        }
        
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let len_answer = answer.count
        guard len_answer > 0 else { return }
        
        let tempWord = rootWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Challenge 1
        guard answer != tempWord else {
            wordError(title: "Same word", message: "The word should not be the same as the one shown")
            return
        }
        
        // Challenge 1
        guard len_answer > 2 else {
            wordError(title: "Too short", message: "The word must has a minimun of 03 letters")
            return
        }
        
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPosbile(word: answer) else {
            wordError(title: "Word not possible", message: "You cant spell that word from '\(rootWord)' ")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You cant just make them up, you know!!")
            return
        }
        
        // Challenge 3
        if len_answer < 6 {
            score += 1
        } else if len_answer >= 6 && len_answer < 10 {
            score += 2
        } else if len_answer >= 10 {
            score += 3
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // String contentsOf: Se pasa un URL y devuelve la info como un String?
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPosbile(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
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

//
//  ContentView.swift
//  Consolidation 3 challenge
//
//  Created by Pedro Pablo on 18/08/22.
//

import SwiftUI

enum Difficulty {
    case easy, normal, hard
}

struct ContentView: View {
    @State private var multiplicationTable = 2 //Tabla de multiplicar
    @State private var quantityOfQuestions = 5 //Nro Preguntas
    @State private var isConfig = true
    @State private var score = 0
    @State private var generatedLabelQuestions = Array<String>() //Label de la pregunta
    @State private var generatedResultQuestions = Array<Int>() //Resultado de la pregunta
    @State private var currentIndexQuestion = 0//Saber en que pregunta estamos
    @State private var currentQuestion = 1//Saber en que pregunta estamos
    @State private var userAnswer = 0
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @FocusState private var focusField: Bool
    
    
    private let listQuantityQuestuins = [5, 10, 20]
    private var selectedDifficulty: Difficulty { //Dificultad
        var default_value = Difficulty.easy
        if quantityOfQuestions == 10 {
            default_value = Difficulty.normal
        } else if quantityOfQuestions == 20 {
            default_value = Difficulty.hard
        }
        return default_value
    }
    private var stringDifficult: String {
        var default_value = "Fácil"
        if quantityOfQuestions == 10 {
            default_value = "Normal"
        } else if quantityOfQuestions == 20 {
            default_value = "Díficil"
        }
        return default_value
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if isConfig {//Configuracion
                    List{
                        Section("Configuración") {
                            VStack {
                                Stepper("Tabla del \(multiplicationTable)", value: $multiplicationTable, in: 1...12, step: 1)
                                HStack {
                                    Text("Preguntas")
                                    Picker("Preguntas", selection: $quantityOfQuestions) {
                                        ForEach(listQuantityQuestuins, id: \.self) {
                                            Text("\($0)")
                                        }
                                    }
                                    .pickerStyle(.segmented)
                                }
                                HStack {
                                    Text("Dificultad: \(stringDifficult)")
                                    Spacer()
                                }
                                
                            }
                            HStack {
                                Spacer()
                                Button {
                                    generateQuestions()
                                    isConfig.toggle()
                                } label: {
                                    Text("Empezar").font(.title2).bold()
                                }
                                .padding(10)
                                .background(Color(red: 0, green: 0, blue: 0.5))
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                                Spacer()
                            }
                        }
                    }
                    .listStyle(.automatic)
                } else { //Preguntas
                    List {
                        Section {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("\(generatedLabelQuestions[currentIndexQuestion])")
                                        .font(.title)
                                    Spacer()
                                }
                                TextField("Respuesta: ", value: $userAnswer, format: .number)
                                    .keyboardType(.numberPad)
                                    .focused($focusField)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {  /// Anything over 0.5 seems to work
                                            self.focusField = true
                                        }
                                    }
                                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                                        if let textField = obj.object as? UITextField {
                                            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                                        }
                                    }
                                    .opacity(currentQuestion > quantityOfQuestions ? 0 : 1)
                                    .disabled(currentQuestion > quantityOfQuestions)
                                HStack {
                                    Text("Pregunta \(currentQuestion > quantityOfQuestions ? quantityOfQuestions : currentQuestion) de \(quantityOfQuestions)")
                                    Spacer()
                                    Text("Puntaje: \(score)")
                                }
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    checkAnswer()
                                } label: {
                                    Text("Contestar").font(.title2).bold()
                                }
                                .padding(10)
                                .background(Color(red: 0, green: 0, blue: 0.5))
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                                .opacity(currentQuestion > quantityOfQuestions ? 0 : 1)
                                .disabled(currentQuestion > quantityOfQuestions)
                                Spacer()
                                
                            }
                            .alert(alertTitle, isPresented: $showingAlert) {
                                Button("Aceptar", role: .cancel) {}
                            } message: {
                                Text(alertMessage)
                            }
                            HStack {
                                Spacer()
                                Button() {
                                    setNewGame()
                                } label: {
                                    Text("Reiniciar").font(.title2).bold()
                                }
                                .padding()
                                .background(Color(red: 0, green: 0, blue: 0.5))
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                                .disabled(currentQuestion < quantityOfQuestions)
                                .opacity(currentQuestion > quantityOfQuestions ? 1 : 0)
                                Spacer()
                            }
                            .disabled(currentQuestion < quantityOfQuestions)
                            .opacity(currentQuestion > quantityOfQuestions ? 1 : 0)
                            
                            HStack {
                                Spacer()
                                Button() {
                                    resetValues()
                                    isConfig.toggle()
                                } label: {
                                    Text("Configurar").font(.title2).bold()
                                }
                                .padding()
                                .background(Color(red: 0, green: 0, blue: 0.5))
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                                Spacer()
                            }
                            .disabled(currentQuestion < quantityOfQuestions)
                            .opacity(currentQuestion > quantityOfQuestions ? 1 : 0)
                            
                        }
                    }
                    
                }//End if
                
            }//ZStack
            .navigationTitle("Tabla de multiplicar").font(.subheadline)
            .toolbar() {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        focusField = false
                    } label: {
                        Text("Hecho").font(.caption)
                    }
                }
            }
        }
    }
    
    func generateQuestions () {
        generatedResultQuestions = Array<Int>()
        generatedLabelQuestions = Array<String>()
        
        for _ in 1...quantityOfQuestions {
            var firstNumber = 1
            switch(selectedDifficulty) {
                case .easy:
                firstNumber = Int.random(in: 1...9)
            case .normal:
                firstNumber = Int.random(in: 10...99)
            case .hard:
                firstNumber = Int.random(in: 100...999)
            }
            let result = firstNumber * multiplicationTable
            let str_result = "Cuánto es \(firstNumber)  x \(multiplicationTable) = ??"
            generatedResultQuestions.append(result)
            generatedLabelQuestions.append(str_result)
        }
        generatedResultQuestions.append(0)
        generatedLabelQuestions.append("Juego terminado")
    }
    
    func checkAnswer() {
        alertTitle = "Incorrecto"
        alertMessage = "La respuesta es \(generatedResultQuestions[currentIndexQuestion])"
        if generatedResultQuestions[currentIndexQuestion] == userAnswer {
            score += 1
            alertTitle = "Correcto"
            alertMessage = "Tu puntaje es \(score)"
        }
        showingAlert = true
        currentIndexQuestion += 1
        currentQuestion += 1
        userAnswer = 0
    }
    
    func resetValues() {
        generatedResultQuestions = Array<Int>()
        generatedLabelQuestions = Array<String>()
        currentIndexQuestion = 0
        score = 0
        userAnswer = 0
        currentQuestion = 1
    }
    
    func setNewGame() {
        generateQuestions ()
        currentIndexQuestion = 0
        score = 0
        userAnswer = 0
        currentQuestion = 1
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

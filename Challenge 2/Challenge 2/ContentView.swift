//
//  ContentView.swift
//  Challenge 2
//
//  Created by Pedro Pablo on 7/08/22.
//

import SwiftUI

enum Choices: Int {
    case rock = 0
    case paper = 1
    case scissors = 2
}

struct ContentView: View {
    
    let answer = ["Piedra", "Papel", "Tijera"]
    let emojis = ["✊", "✋", "✌️"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var systemTextChoice = ""
    @State private var alertResult = false
    @State private var intents = 0
    @State private var alertTitle = "Resultado"
    private let maxIntents = 5
    
    var body: some View {
    
        ZStack {
            
            RadialGradient(stops: [
                            .init(color: Color(red: 0.8, green: 0.2, blue: 0.2), location: 0.3),
                            .init(color: Color(red: 0.2, green: 0.6, blue: 0.6), location: 0.3)
                        ], center: .top, startRadius: 250, endRadius: 700)
                            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Piedra Papel Tijera")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(5)
                VStack (spacing: 15){
                    Text("Elija opción")
                        .foregroundColor(.white)
                    HStack {
                        Spacer()
                        ForEach(0..<3) {number in
                            Button() {
                                //accion
                                selectedOption(number)
                            } label: {
                                Text("\(emojis[number])")
                                    .font(.system(size: 65))
                            }
                            .padding()
                            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                            .clipShape(Capsule())

                        }
                        Spacer()
                    }
                    .padding()
                    HStack {
                        Text("Puntaje: \(score)")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                        Spacer()
                        Text("Intentos: \(intents)/\(maxIntents)")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }.padding(20)
                    
                }
                Spacer()
            }
            .alert(alertTitle, isPresented: $alertResult) {
                if intents < maxIntents {
                    Button("Continuar", action: nextChoice)
                } else {
                    Button("Reiniciar", action: resetGame)
                }
            } message: {
                Text("\(systemTextChoice)")
            }
        }
    }
    
    func selectedOption (_ choice: Int) {
        var strAnswer = "Ganas"
        if correctAnswer == choice {//Son iguales
            strAnswer = "Empate"
        } else {
            switch choice {
            case Choices.rock.rawValue:
                if correctAnswer == Choices.paper.rawValue {
                    score -= 1
                    strAnswer = "Pierdes"
                } else {//Es tijera
                    score += 1
                }
            case Choices.paper.rawValue:
                if correctAnswer == Choices.rock.rawValue {
                    score += 1
                } else {//Es tijera
                    strAnswer = "Pierdes"
                    score -= 1
                }
            case Choices.scissors.rawValue:
                if correctAnswer == Choices.rock.rawValue {
                    strAnswer = "Pierdes"
                    score -= 1
                } else {
                    score += 1
                }
            default:
                break
            }
        }
        systemTextChoice = """
        Sistema: \(answer[correctAnswer])
        Tu elección: \(answer[choice])
        \(strAnswer)
        """
        intents += 1
        if intents == maxIntents {
            alertTitle = "Juego terminado"
            systemTextChoice = """
            Sistema: \(answer[correctAnswer])
            Tu elección: \(answer[choice])
            \(strAnswer)
            Puntaje final: \(score)
            """

        }
        alertResult = true
    }
    
    func nextChoice() {
        systemTextChoice = ""
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        nextChoice()
        score = 0
        intents = 0
        alertTitle = "Resultado"
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

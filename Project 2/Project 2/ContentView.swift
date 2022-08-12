//
//  ContentView.swift
//  Project 2
//
//  Created by Pedro Pablo on 1/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var maxIntents = 8
    @State private var intents = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    /*
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
            }
        
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    */
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Adivina la bandera de")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Toca la bandera")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(image: countries[number])
//                            Image(countries[number])
//                                .renderingMode(.original)
//                                .clipShape(Capsule())
//                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Puntaje: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continuar", action: askQuestion)
        } message: {
            Text("Tu puntaje es \(score)")
        }
        .alert("Juego terminado", isPresented: $showingFinalScore) {
            Button() {
                resetGame()
            } label: {
                Text("Reiniciar")
            }
        } message: {
            Text("Tu puntaje final es \(score)")
                .font(.subheadline.bold())
                .foregroundColor(.red)
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correcto"
            score += 1
        } else {
            scoreTitle = "Mal! Esa es la bandera de \(countries[number])"
            score -= 1
        }
        intents += 1

        if maxIntents == intents {
            showingFinalScore = true
        } else {
            showingScore = true
        }
        
    }
    
    func resetGame() {
        score = 0
        intents = 0
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    struct FlagImage: View {
        let image: String
        var body: some View {
            Image(image)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/**
 
 //Mensajes de alerta
 
 struct ContentView: View {
     @State private var showingAlert = false
     
     var body: some View {
         Button() {
             showingAlert = true
         } label: {
             Text("Show alert").background(.mint)
         }
         .alert("Important message", isPresented: $showingAlert) {
             Button("Delete", role: .destructive) {}
             Button("Cancel", role: .cancel) {}
         }
     }
 }
 
 
 //Botones
 
 struct ContentView: View {
     var body: some View {
         VStack {
             Button("Button 1") {}
                 .buttonStyle(.bordered)
             Button("Button 2", role: .destructive) {}
                 .buttonStyle(.bordered)
             Button("Button 3") {}
                 .buttonStyle(.borderedProminent)
                 .tint(.mint)
             Button("Button 4", role: .destructive) {}
                 .buttonStyle(.borderedProminent)
             
             
             Button() {
                 print("Button was tapped!")
             } label: {
                 Image(systemName: "pencil").renderingMode(.original) //Usar colores originales de la imagen
                 Label("Edit", systemImage: "pencil")
 //                Text("Boton 5")
 //                    .padding()
 //                    .foregroundColor(.white)
 //                    .background(.red)
             }
         }
         
     }
 }
 

 //Gradiantes
 struct ContentView: View {
     var body: some View {
         
         AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
         RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
         
         LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
         LinearGradient(gradient: Gradient(stops: [
             .init(color: .white, location: 0.45),
             .init(color: .black, location: 0.55)
 //            Gradient.Stop(color: .black, location: 0.55)
         ]), startPoint: .top, endPoint: .bottom)
         
     }
 }
 
 //Colores
 struct ContentView: View {
     var body: some View {
         ZStack {
             VStack(spacing:0) {
                 Color.red
                 Color.blue
             }
             
 //            Color(red: 1, green: 0.8, blue: 0)
             Text("Your content")
                 .foregroundColor(.secondary)
                 .foregroundStyle(.secondary)
                 .padding(50)
                 .background(.ultraThinMaterial)
             
         }.ignoresSafeArea()
     }
 }
 
 
 */

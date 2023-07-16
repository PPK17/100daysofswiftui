//
//  ContentView.swift
//  project 8
//
//  Created by Pedro Pablo on 26/09/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .vertical])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



/**
 
 
 $$$$$$$$$$$$$$$$$$   GridItem   4$$$$$$$$$$$$$$$$$$$$$
 
 struct ContentView: View {
     let layout = [
         GridItem(.adaptive(minimum: 80, maximum: 120))
     ]
     
 //    let layout = [
 //        GridItem(.fixed(80)),
 //        GridItem(.fixed(80)),
 //        GridItem(.fixed(80))
 //    ]
     
     var body: some View {
         ScrollView {
             LazyVGrid(columns: layout) {
                 ForEach(0..<1000) {
                     Text("Item \($0)")
                 }
             }
         }
         
         ScrollView(.horizontal) {
             LazyHGrid(rows: layout) {
                 ForEach(0..<1000) {
                     Text("Item \($0)")
                 }
             }
         }
         
         
     }
 }
 
 $$$$$$$$$$$$$$$$$$$$$$ JSONDecore $$$$$$$$$$$$$$$
 
 struct User: Codable {
     let name: String
     let address: Address
 }

 struct Address: Codable {
     let street: String
     let city: String
 }

 struct ContentView: View {
     var body: some View {
         Button("Decode JSON") {
             let input = """
             {
             "name": "Tallow",
             "address": {
                 "street": "street 123",
                 "city": "Nasha"
                 }
             }
             """
             
             let data = Data(input.utf8)
             
             if let user = try? JSONDecoder().decode(User.self, from: data) {
                 print(user.address.street)
             }
             
             
         }
         
         
     }
 }
 
 
 $$$$$$$$$$$$$$$$$$ NavigationLink $$$$$$$$$$$$$$$$$
 
 struct ContentView: View {
     var body: some View {
         NavigationView {
             List(0..<100) { row in
                 NavigationLink {
                     Text("Detail \(row)")
                 } label: {
                     Text("Row \(row)")
                 }
             }
             .navigationTitle("SwiftUI")
         }
         
         
     }
 }
 
 
 $$$$$$$$$$$$$$ ScrollView ##$$$$$$$$$$$$$
 
 struct CustomText: View {
     let text: String
     
     var body: some View {
         Text(text)
     }
     
     init(_ text: String) {
         print("Creating a new CustomText")
         self.text = text
     }
     
 }

 struct ContentView: View {
     var body: some View {
         ScrollView {
             LazyVStack(spacing: 10) {
                 ForEach(0..<100) {
                     CustomText("Item \($0)")
                         .font(.title)
                 }
             }
             .frame(maxWidth: .infinity)
         }
         
         ScrollView(.horizontal) {
             LazyHStack(spacing: 10) {
                 ForEach(0..<100) {
                     CustomText("Item \($0)")
                         .font(.title)
                 }
             }
             .frame(maxWidth: .infinity)
         }
         
     }
 }
 
 *********** GeometryReader ****************
 
 struct ContentView: View {
     var body: some View {
         GeometryReader { geo in
             Image("Cat03")
                 .resizable()
                 .scaledToFit()
                 .frame(width: geo.size.width * 0.8)
                 .frame(width: geo.size.width, height: geo.size.height)
         }
         
     }
 }
 */

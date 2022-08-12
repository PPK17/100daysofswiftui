//
//  ContentView.swift
//  Project 3
//
//  Created by Pedro Pablo on 3/08/22.
//

import SwiftUI


struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
    
}

struct TextColor: ViewModifier {
    let font: Font
    let colorText: Color
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorText)
            .background(.red)
    }
}

extension View {
    func customStyleText (font: Font = .largeTitle, color: Color = .blue) -> some View {
        modifier(TextColor(font: font, colorText: color))
    }
}


struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
        
        Text("Texto")
            .customStyleText(font: .caption)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 print(type(of: self.body))
 
 
 // CUSTOM MODIFIERS
 struct Watermark: ViewModifier {
     var text: String
     func body(content: Content) -> some View {
         ZStack(alignment: .bottomTrailing) {
             content
             
             Text(text)
                 .font(.caption)
                 .foregroundColor(.white)
                 .padding(5)
                 .background(.blue)
         }
     }
 }

 struct Title: ViewModifier {
     func body(content: Content) -> some View {
         content
             .font(.largeTitle)
             .foregroundColor(.white)
             .padding()
             .background(.blue)
             .clipShape(RoundedRectangle(cornerRadius: 10))
     }
 }

 extension View {
     func titleStyle() -> some View {
         modifier(Title())
     }
     func watermarked(with text: String) -> some View {
         modifier(Watermark(text: text))
     }
 }

 struct ContentView: View {
     var body: some View {
         Text("Hello, world!")
             .titleStyle()
             .watermarked(with: "Hacking with swift")
     }
 }
 
 
 
 struct CapsuleText: View {
     var text: String

     var body: some View {
         Text(text)
             .font(.largeTitle)
             .padding()
             .foregroundColor(.white)
             .background(.blue)
             .clipShape(Capsule())
     }
 }
 
 struct ContentView: View {
     var body: some View {
         VStack(spacing: 10) {
             CapsuleText(text: "First")
             CapsuleText(text: "Second")
         }
     }
 }
 
 VStack(spacing: 10) {
     CapsuleText(text: "First")
         .foregroundColor(.white)
     CapsuleText(text: "Second")
         .foregroundColor(.yellow)
 }
 
 
 
 */

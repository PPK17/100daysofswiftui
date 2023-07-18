//
//  ContentView.swift
//  Project 9
//
//  Created by Pedro Pablo on 16/07/23.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Arrow(correction_x: 20).stroke(LinearGradient(
                    colors: [color(for: value, brightness: 1), color(for: value, brightness: 0.5)],
                                             startPoint: .top, endPoint: .bottom))
            }
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
    
}

struct Arrow: Shape {
    var correction_x = 15
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX +  CGFloat(correction_x), y: rect.maxY))
        path.addLine(to: .init(x: 20, y: rect.maxY))
        path.addLine(to: .init(x: 60, y: rect.maxY))
        path.addLine(to: .init(x: 60, y: rect.midY))
        path.addLine(to: .init(x: 80, y: rect.midY))
        path.addLine(to: .init(x: 40, y: rect.minY))
        path.addLine(to: .init(x: 0, y: rect.midY))
        path.addLine(to: .init(x: 20, y: rect.midY))
        path.addLine(to: .init(x: 20, y: rect.maxY))
        
        return path
    }
}

struct ContentView: View {
    @State private var pathProgress = 0.0
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            Text("Arrow with animation")
                .padding(.bottom)
            Arrow()
                .trim(from: 0.0, to: pathProgress)
                .stroke(Color.orange, lineWidth: 10)
                .frame(width: 80, height: 200, alignment: .leading)
            Slider(value: $pathProgress, in: 0.0...1.0)
            Text("Arrow with gradient")
                .padding(.bottom)
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 80, height: 200, alignment: .leading)
            Slider(value: $colorCycle)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


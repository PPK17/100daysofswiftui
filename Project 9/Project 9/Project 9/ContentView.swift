//
//  ContentView.swift
//  Project 9
//
//  Created by Pedro Pablo on 16/07/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("Hello world")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 
 // spirograph
 
 struct Spirograph: Shape {
     let innerRadius: Int
     let outerRadius: Int
     let distance: Int
     let amount: Double
 
     func gcd(_ a: Int, _ b: Int) -> Int {
         var a = a
         var b = b
         
         while b != 0 {
         let temp = b
         b = a % b
         a = temp
         }
         
         return a
     }
 
 func path(in rect: CGRect) -> Path {
     let divisor = gcd(innerRadius, outerRadius)
     let outerRadius = Double(self.outerRadius)
     let innerRadius = Double(self.innerRadius)
     let distance = Double(self.distance)
     let difference = innerRadius - outerRadius
     let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount

     // more code to come
 var path = Path()

 for theta in stride(from: 0, through: endPoint, by: 0.01) {
     var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
     var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

     x += rect.width / 2
     y += rect.height / 2

     if theta == 0 {
         path.move(to: CGPoint(x: x, y: y))
     } else {
         path.addLine(to: CGPoint(x: x, y: y))
     }
 }

 return path
 
 }
 
 }
 
 struct ContentView: View {
     @State private var innerRadius = 125.0
     @State private var outerRadius = 75.0
     @State private var distance = 25.0
     @State private var amount = 1.0
     @State private var hue = 0.6

     var body: some View {
         VStack(spacing: 0) {
             Spacer()

             Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                 .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                 .frame(width: 300, height: 300)

             Spacer()

             Group {
                 Text("Inner radius: \(Int(innerRadius))")
                 Slider(value: $innerRadius, in: 10...150, step: 1)
                     .padding([.horizontal, .bottom])

                 Text("Outer radius: \(Int(outerRadius))")
                 Slider(value: $outerRadius, in: 10...150, step: 1)
                     .padding([.horizontal, .bottom])

                 Text("Distance: \(Int(distance))")
                 Slider(value: $distance, in: 1...150, step: 1)
                     .padding([.horizontal, .bottom])

                 Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                 Slider(value: $amount)
                     .padding([.horizontal, .bottom])

                 Text("Color")
                 Slider(value: $hue)
                     .padding(.horizontal)
             }
         }
     }
 }
 
 
 // ANIMATE MORE THAN 01 CHECKBOARD
 
 struct Checkerboard: Shape {
     var rows: Int
     var columns: Int
     
     var animatableData: AnimatablePair<Double, Double> {
         get {
             AnimatablePair(Double(rows), Double(columns))
         }
         
         set {
             rows = Int(newValue.first)
             columns = Int(newValue.second)
         }
     }
     
     func path(in rect: CGRect) -> Path {
         var path = Path()
         
         let rowSize = rect.height / Double(rows)
         let columnSize = rect.width / Double(columns)
         
         for row in 0..<rows {
             for column in 0..<columns {
                 if (row + column).isMultiple(of: 2) {
                     let startX = columnSize * Double(column)
                     let startY = rowSize * Double(row)
                     
                     let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                     path.addRect(rect)
                 }
             }
         }
         return path
     }
     
 }


 struct ContentView: View {
     @State private var rows = 4
     @State private var columns = 4
     
     var body: some View {
         Checkerboard(rows: rows, columns: columns)
             .onTapGesture {
                 withAnimation(.linear(duration: 3)) {
                     rows = 8
                     columns = 16
                 }
             }
     }
 }
 
 
 // animatableData
 
 struct Trapezoid: Shape {
     var insetAmount: Double
     
     var animatableData: Double {
         get { insetAmount }
         set { insetAmount = newValue}
     }
     
     func path(in rect: CGRect) -> Path {
         var path = Path()
         
         path.move(to: CGPoint(x: 0, y: rect.maxY))
         path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
         path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
         path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
         path.addLine(to: CGPoint(x: 0, y: rect.maxY))
         
         return path
     }
 }

 struct ContentView: View {
     @State private var insetAmount = 50.0
     
     var body: some View {
         Trapezoid(insetAmount: insetAmount)
             .frame(width: 200, height: 100)
             .onTapGesture {
                 withAnimation {
                     insetAmount = Double.random(in: 10...90)
                 }
             }
     }
 }
 
 
 // BLEND MODEL
 
 struct ContentView: View {
     @State private var amount = 0.0
     
     var body: some View {
         VStack {
 //            ZStack{
 //                Circle()
 //                    .fill(Color(red: 1, green: 0, blue: 0))
 //                    .frame(width: 200 * amount)
 //                    .offset(x: -50, y: -80)
 //                    .blendMode(.screen)
 //
 //                Circle()
 //                    .fill(Color(red: 0, green: 1, blue: 0))
 //                    .frame(width: 200 * amount)
 //                    .offset(x: 50, y: -80)
 //                    .blendMode(.screen)
 //
 //                Circle()
 //                    .fill(Color(red: 0, green: 0, blue: 1))
 //                    .frame(width: 200 * amount)
 //                    .blendMode(.screen)
 //            }
 //            .frame(width: 300, height: 300)
             Image("Cat03")
                 .resizable()
                 .scaledToFit()
                 .frame(width: 200, height: 200)
                 .saturation(amount)
                 .blur(radius: (1 - amount) * 20)
             Slider(value: $amount).padding()
         }
         .frame(maxWidth: .infinity, maxHeight: .infinity)
         .background(.black)
         .ignoresSafeArea()
 //        ZStack{
 //            Image("Cat03")
 //                .colorMultiply(.red)
 //
 //            Rectangle()
 //                .fill(.red)
 //                .blendMode(.multiply)
 //
 //        }
         
     }
 }
 
 // USING METAL
 
 struct ColorCyclingCircle: View {
     var amount = 0.0
     var steps = 100
     
     var body: some View {
         ZStack {
             ForEach(0..<steps) { value in
                 Circle()
                     .inset(by: Double(value))
                     .strokeBorder(LinearGradient(
                         colors: [color(for: value, brightness: 1), color(for: value, brightness: 0.5)],
                         startPoint: .top, endPoint: .bottom), lineWidth: 2)
             }
         }
         .drawingGroup()
     }
     
     func color(for value: Int, brightness: Double) -> Color {
         var targetHue = Double(value) / Double(steps) + amount
         if targetHue > 1 {
             targetHue -= 1
         }
         return Color(hue: targetHue, saturation: 1, brightness: brightness)
     }
     
 }


 struct ContentView: View {
     @State private var colorCycle = 0.0
     
     var body: some View {
         VStack {
             ColorCyclingCircle(amount: colorCycle)
                 .frame(width: 300, height: 300)
             Slider(value: $colorCycle)
         }
         
     }
 }
 
 
 // BORDER WITH IMAGE
 
 struct ContentView: View {
     
     var body: some View {
         Capsule()
             .strokeBorder(ImagePaint(image: Image("Cat03"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5),scale: 0.3),
                           lineWidth: 20)
             .frame(width: 300, height: 200)
 //        Text("Hello")
 //            .frame(width: 300, height: 300)
 //            .border(ImagePaint(image: Image("Cat03"), sourceRect: CGRect(x: 0, y: 0.4, width: 1, height: 0.3),scale: 0.2), width: 50)
         
     }
 }
 
 
 // FLOWER
 
 
 struct Flower: Shape {
     var petalOffset = -20.0
     var petalwidth = 100.0
     
     func path(in rect: CGRect) -> Path {
         var path = Path()
         for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
             let rotation = CGAffineTransform(rotationAngle: number)
             let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
             
             let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalwidth, height: rect.width / 2))
             let rotatedPetal = originalPetal.applying(position)
             
             path.addPath(rotatedPetal)
         }
         return path
         
     }
     
 }


 struct ContentView: View {
     @State private var petalOffset = -20.0
     @State private var petalWidth = 100.0
     
     var body: some View {
         VStack {
             Flower(petalOffset: petalOffset, petalwidth: petalWidth)
                 .fill(.red, style: FillStyle(eoFill: true))
             Text("Offset")
             Slider(value: $petalOffset, in: -40...40)
             Text("Width")
             Slider(value: $petalOffset, in: 0...100)
         }
         
     }
 }
 
 
 // SHAPE
 
 struct Triangle: Shape {
     func path(in rect: CGRect) -> Path {
         var path = Path()
         path.move(to: CGPoint(x: rect.midX, y: rect.minY))
         path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
         path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
         path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
         return path
     }
 }

 struct Arc: InsettableShape {
     let startAngle: Angle
     let endAngle: Angle
     let clockwise: Bool
     var insetAmount = 0.0
     
     func path(in rect: CGRect) -> Path {
         let rotationAdjusment = Angle.degrees(90)
         let modifiedStart = startAngle -  rotationAdjusment
         let modifiedEnd = endAngle -  rotationAdjusment
         
         var path = Path()
         path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
         return path
     }
     
     func inset(by amount: CGFloat) -> some InsettableShape {
         var arc = self
         arc.insetAmount += amount
         return arc
     }
     
 }
 
 
 
 // Triangulo con borders redondeados
 struct ContentView: View {
     var body: some View {
         Path { path in
             path.move(to: CGPoint(x: 200, y: 100))
             path.addLine(to: CGPoint(x: 100, y: 300))
             path.addLine(to: CGPoint(x: 300, y: 300))
             path.addLine(to: CGPoint(x: 200, y: 100))
             //path.closeSubpath()
         }
         .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
     }
 }
 
 
 */

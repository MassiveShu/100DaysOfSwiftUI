//
//  ContentView.swift
//  Drawing
//
//  Created by Max Shu on 29.07.2022.
//

import SwiftUI

struct Arrow: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            
            path.addLines([
                CGPoint(x: width * 0.4, y: height),
                CGPoint(x: width * 0.4, y: height * 0.4),
                CGPoint(x: width * 0.2, y: height * 0.4),
                CGPoint(x: width * 0.5, y: height * 0.1),
                CGPoint(x: width * 0.8, y: height * 0.4),
                CGPoint(x: width * 0.6, y: height * 0.4),
                CGPoint(x: width * 0.6, y: height)
            ])
            path.closeSubpath()
        }
    }
}

struct ContentView: View {
    @State private var amount = 0.0
    
    var body: some View {
        Spacer()
        
        Arrow()
            .stroke(lineWidth: 5 * amount)
            .fill(.green)
            .frame(width: 400, height: 600)
            .shadow(color: Color.orange, radius: 5, y: 5)
        // 2) Animation
                    .onTapGesture {
                        withAnimation {
                            amount = Double.random(in: 1...3)
                        }
                    }
        Spacer()
        
        HStack {
            Image(systemName: "minus")
            Slider(value: $amount)
                .accentColor(Color.orange)
            Image(systemName: "plus")
        } .foregroundColor(Color.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

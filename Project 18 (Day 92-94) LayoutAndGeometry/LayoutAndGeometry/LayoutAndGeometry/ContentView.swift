//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Max Shu on 04.09.2022.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .orange, .pink, .blue, .purple, .yellow]
    
    var body: some View {
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(maxWidth: .infinity)
// 3. For a real challenge make the views change color as you scroll. For the best effect, you should create colors using the Color(hue:saturation:brightness:) initializer, feeding in varying values for the hue.
                                .background(Color(
                                            hue: min(1, geo.frame(in: .global).origin.y * 0.9 / (fullView.size.height)),
                                            saturation: geo.frame(in: .global).origin.y * 1.5 / (fullView.size.height),
                                            brightness: 1
                                            ))
                                .background(colors[index % 7])
                                .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
// 1. Make views near the top of the scroll view fade out to 0 opacity – I would suggest starting at about 200 points from the top.
                                .opacity(geo.frame(in: .global).origin.y > 270 ? 1 :
                                            geo.frame(in: .global).origin.y / 500)
// 2. Make views adjust their scale depending on their vertical position, with views near the bottom being large and views near the top being small. I would suggest going no smaller than 50% of the regular size.
                                .scaleEffect(
                                    x: max(0.15, geo.frame(in: .global).origin.y + fullView.size.height * 0.4) / (fullView.size.height),
                                    y: max(0.25, geo.frame(in: .global).origin.y + fullView.size.height * 0.4) / (fullView.size.height),
                                    anchor: .center)
                        }
                        .frame(height: 45)
                    }
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

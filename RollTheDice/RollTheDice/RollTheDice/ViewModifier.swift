//
//  ViewModifier.swift
//  RollTheDice
//
//  Created by Max Shu on 09.09.2022.
//

import SwiftUI

struct MintButtonModifier: ViewModifier {
    var size: CGFloat
    var width: CGFloat
    func body(content: Content) -> some View {
        content
            .frame(width: width)
            .padding(.all, size/2)
            .foregroundColor(.black)
            .font(.system(size: size))
            .clipShape(Capsule())
            .background(.mint)
            .frame(width: width)
      
    }
}

extension View {
    func mintButton( fontSize: CGFloat = 16, width: CGFloat = 100) -> some View {
        modifier(MintButtonModifier(size: fontSize, width: width))
    }
}

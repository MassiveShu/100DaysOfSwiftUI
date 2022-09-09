//
//  RolledDicesView.swift
//  RollTheDice
//
//  Created by Max Shu on 09.09.2022.
//

import SwiftUI

struct RolledDicesView: View {
    var numberOfDices: Int
    var diceSide: Int
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isRolled = false
    @State private var isResultsSaved = false
    @State private var results = [Int]()

    var body: some View {
        VStack {
            Spacer()
            Spacer()
            if isRolled {
                DicesGridView(results: results.map{String($0)})
            } else {
                DicesGridView(results: Array(repeating: "?", count: numberOfDices))
            }
            Spacer()
            Spacer()
            buttonsView
        }.onAppear {
            withAnimation(.easeOut(duration: 0.5).delay(0.35)) {
                rollDices()
            }
            
        }.alert("Results saved", isPresented: $isResultsSaved) {
            Button(role: .cancel){
                dismiss()
            } label: {
                Text("OK")
            }
        }
    }
    
    var buttonsView: some View {
        HStack(spacing: 20) {
            Button("Back") {
                dismiss()
            }
            .mintButton(fontSize: 20, width: 170)
            .clipShape(Capsule())
            .padding()
            .font(.headline)
        }
    }
    
    func rollDices() {
        for _ in 0..<numberOfDices {
            let number = Int.random(in: 1...diceSide)
            results.append(number)
        }
        
        isRolled = true
    }
    
}

struct DicesGridView: View {
    
    let results: [String]
    var size: CGFloat = 40
    
    let columns = [
        GridItem(.flexible(minimum: 30, maximum: 50)),
        GridItem(.flexible(minimum: 30, maximum: 50)),
        GridItem(.flexible(minimum: 30, maximum: 50)),
        GridItem(.flexible(minimum: 30, maximum: 50)),
        GridItem(.flexible(minimum: 30, maximum: 50)),
        GridItem(.flexible(minimum: 30, maximum: 50)),

    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: size / 1.6) {
            ForEach(0..<results.count) { index in
                Text("\(results[index])")
                    .foregroundColor(.red)
                    .font(.system(size: size / 1)).bold()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 3)
                    .frame(width: size, height: size))
            }
        }.padding()
    }
}

struct RolledDicesView_Previews: PreviewProvider {
    static var previews: some View {
        RolledDicesView(numberOfDices: 5, diceSide: 10)
    }
}

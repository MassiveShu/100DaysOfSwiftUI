//
//  ContentView.swift
//  paperRockScissors
//
//  Created by Max Shu on 13.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var rockPaperScissors = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State var countMe: Int = 0
    @State var countComp: Int = 0
    
    
    var body: some View {
        ZStack {
            AngularGradient(colors: [.yellow, .red, .green, .blue, .purple, .pink], center: .center,
                            startAngle: .degrees(90), endAngle: .degrees(360))
            .ignoresSafeArea()
//            RadialGradient(stops: [
//                .init(color: Color(red: 0, green: 0, blue: 1), location: 0.5),
//                .init(color: Color(red: 220, green: 250, blue: 0), location: 0.5)
//            ], center: .top, startRadius: 300, endRadius: 600)
//                .ignoresSafeArea()
            
            VStack(spacing: 25) {
            Text("Rock, Paper, Scissors")
                .font(Font.custom("AvenirLTStd-Black", size: 35))
                .foregroundStyle(.primary)
                .font(.largeTitle.weight(.heavy))
                .foregroundColor(.white)
                .padding()
            Text("The Game")
                .font(Font.custom("AvenirLTStd-Black", size: 15))
                .foregroundStyle(.primary)
                .font(.body.weight(.heavy))
                .foregroundColor(.white)
                .position(.init(x: 355, y: 5))
                
        Spacer()
        }
            
        VStack(spacing: 50) {
            ForEach(0..<3) {number in
                Button {
                    picTapped(number)
                } label: {
                    Image(rockPaperScissors[number])
                        .renderingMode(.original)
                        .shadow(radius: 50)
                }
            }
            .padding()
            
        }
            
            .frame(maxWidth: .infinity)
            .padding(.vertical, 25)
            .padding(.horizontal, 65)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .padding()
            .padding()

            VStack {
                Spacer()
                VStack(spacing: 7) {
                Text("You: \(countMe)")
                        .font(Font.custom("AvenirLTStd-Black", size: 25))
                        .fontWeight(.heavy)
                        .font(.title)
                        .foregroundColor(.black)
                    VStack {
                    Text("Computer: \(countComp)")
                        .font(Font.custom("AvenirLTStd-Black", size: 25))
                        .fontWeight(.heavy)
                        .font(.title)
                        .foregroundColor(.black)
                        
                }
            }
        }
    }
        
    
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Try again", action: winGame)
        }
}
       
    func picTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Lucky you are!"
            self.countMe += 1
        } else if number != correctAnswer {
            scoreTitle = "Computer won"
            self.countComp += 1
            //restart()
        } else {
            restart()
        }
        showingScore = true
    }
    
    func restart() {
        countMe = 0
    }
    
    func winGame() {
        rockPaperScissors.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

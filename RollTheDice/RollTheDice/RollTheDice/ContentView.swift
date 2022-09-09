//
//  ContentView.swift
//  RollTheDice
//
//  Created by Max Shu on 09.09.2022.
//

import SwiftUI

enum DiceType: Int, Identifiable, CaseIterable {
    case fourSides = 4
    case sixSides = 6
    case eightSides = 8
    case tenSides = 10
    
    static var allCases: [Int] {
        return [fourSides.rawValue, sixSides.rawValue, eightSides.rawValue, tenSides.rawValue]
    }
    
    var id: DiceType { self }
    
}

struct ContentView: View {
    
    @State private var numberOfDices = 2
    @State private var diceType = DiceType.sixSides
    @State private var isRolledViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                diceTypeView
                diceQuantityView
                rollDicesView
            }
            .navigationTitle("Roll The Dice")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isRolledViewPresented) {
                RolledDicesView(numberOfDices: numberOfDices, diceSide: diceType.rawValue)
            }
        }
    }
    
    var diceTypeView: some View {
        VStack {
            Spacer()
            Text("How many sides in your dice?")
            
            Picker("How many sides in your dices?", selection: $diceType) {
                ForEach(DiceType.allCases) { dice in
                    Text("\(dice.rawValue)")
                } .onChange(of: diceType) { newValue in
                    diceType = DiceType(rawValue: newValue.rawValue) ?? .sixSides
                }
            } .pickerStyle(.segmented)
        }
    }
    
    var diceQuantityView: some View {
        VStack(alignment: .center) {
            Text("Dices")
            Text("\(numberOfDices)")
                .font(.largeTitle.bold())
            Stepper(label: { },
                    onIncrement: { numberOfDices += 1 },
                    onDecrement: {
                if numberOfDices > 1 {
                        numberOfDices -= 1
                }
            }
                    ).labelsHidden()
            
            Spacer()
            
        } .padding(.vertical, 25)
    }
    
    var rollDicesView: some View {
        VStack {
            Text("Push the button to roll dices")
            Button("Roll dice") {
                isRolledViewPresented.toggle()
            }
            .mintButton(fontSize: 20, width: 170)
            .clipShape(Capsule())
            .padding()
            .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  unitConversion
//
//  Created by Max Shu on 10.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var celsius = 0
    @State private var fahrenheits = 0

    
    var toFahrenheitsCalculation: Double {
        let cels = Double(celsius)
        
        let fahrenheitIs = (cels * 1.8) + 32
        return Double(fahrenheitIs)
    }
    
    var toCelsiusCalculation: Double {
        let fahren = Double(fahrenheits + 32)
        
        let celsiusIs = ((fahren - 32) * 5 / 9)
        return Double(celsiusIs).rounded()
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Celsuis", selection: $celsius) {
                        ForEach(0..<41) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.automatic)
                    Text("\(toFahrenheitsCalculation, format: .number) ℉")
                } header: {
                    Text("Celsius to Fahrenheits:")
                }
                .padding(1)
                Section {
                    Picker("Fahrenheits", selection: $fahrenheits) {
                        ForEach(32..<105) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.automatic)
                    Text("\(toCelsiusCalculation, format: .number) ºC")
                } header: {
                    Text("Fahrenheits to Celsius:")
            }
                .padding(1)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Unit Conversion")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
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

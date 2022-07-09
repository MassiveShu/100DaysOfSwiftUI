//
//  ContentView.swift
//  WeSplit
//
//  Created by Max Shu on 08.07.2022.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Max", "Yura", "Vovka"]
    @State private var selectedStudents = "Harry"

    var body: some View {
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudents) {
                    ForEach(students, id: \.self) {
                        Text($0)
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

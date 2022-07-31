//
//  AddHabit.swift
//  Habits
//
//  Created by Max Shu on 30.07.2022.
//

import SwiftUI

struct AddHabit: View {
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var type = "Sport"
    
    let types = ["Heath", "Sport", "Home"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Habit title", text: $title)
                    } header: {
                        Text("Title:")
                    }
                    
                    Section {
                        TextEditor(text: $description)
                            .frame(height: 150)
                    } header: {
                        Text("Description:")
                    }
                    
                    Section {
                        Picker("Type", selection: $type) {
                            ForEach(types, id: \.self) {
                                Text($0)
                            }
                        } .pickerStyle(.segmented)
                    } header: {
                        Text("Habit type:")
                    }
                }
            }
            .navigationTitle("Create a new habit")
            .toolbar {
                Button("Save") {
                    let item = HabitsItem(title: title, description: description, type: type, daysInRow: 0)
                    habits.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}

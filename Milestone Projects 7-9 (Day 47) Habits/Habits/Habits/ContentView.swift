//
//  ContentView.swift
//  Habits
//
//  Created by Max Shu on 30.07.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddHabits = false
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(habits.items) { item in
                    NavigationLink {
                        HStack {
                            VStack(alignment: .center) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                        }
                        
                        InfoHabitView(habits: Habits(), habit: HabitsItem.testHabit)
                    } label: {
                        HStack {
                            Text("\(item.title)")
                            Spacer()
                            Label("\(item.daysInRow)", systemImage: "flame")
                        }
                    }
                }
                .onDelete(perform: removeItems)
                
            }
            .navigationTitle("My Habits")
            .toolbar {
                Button {
                    showingAddHabits = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabits) {
                AddHabit(habits: habits)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  InfoHabitView.swift
//  Habits
//
//  Created by Max Shu on 30.07.2022.
//

import SwiftUI

struct InfoHabitView: View {
    @ObservedObject var habits: Habits
    @State var count: Int = 0
    
    let habit: HabitsItem
    
    var body: some View {
        VStack(spacing: 50) {
            descriptionView
            Spacer()
            Spacer()
            buttonsView
            Spacer()
            Spacer()
        } .padding()
    }

var descriptionView: some View {
        ZStack {
            VStack {
                        Text("Finished days:")
                    .font(.largeTitle)
                        Text("\(count)")
                    .font(.largeTitle)
                    .font(.headline)
                }
            } .padding()
        }
    
    var buttonsView: some View {
        VStack {
            Button(action: {
                self.count += 1
            }) {
                Text("Add one day")
            }
        }
    }
    
    
struct InfoHabitView_Previews: PreviewProvider {
    static var previews: some View {
        InfoHabitView(habits: Habits(), habit: HabitsItem.testHabit)
    }
}
    func updateHabit() {
        
    }
}

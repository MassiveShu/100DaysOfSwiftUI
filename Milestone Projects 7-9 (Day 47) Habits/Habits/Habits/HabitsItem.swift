//
//  HabitsItem.swift
//  Habits
//
//  Created by Max Shu on 30.07.2022.
//

import Foundation
import SwiftUI


struct HabitsItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var type: String
    var daysInRow: Int
    
    static var testHabit = HabitsItem(title: "title", description: "description", type: "type", daysInRow: 0)

}

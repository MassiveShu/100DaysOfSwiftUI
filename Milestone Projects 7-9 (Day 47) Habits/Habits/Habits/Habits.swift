//
//  Habits.swift
//  Habits
//
//  Created by Max Shu on 30.07.2022.
//

import Foundation

class Habits: ObservableObject {
   
    @Published var items = [HabitsItem]() {
        didSet {
            saveItems()
            }
        }

    init() {
       items = readItems()
    }
    
    private func saveItems() {
        let encoder = JSONEncoder()
        
        if let items = try? encoder.encode(items) {
            UserDefaults.standard.set(items, forKey: "items")
        }
    }
    
    private func readItems() -> [HabitsItem] {
        guard let data = UserDefaults.standard.data(forKey: "items") else { return [] }

        let decoder = JSONDecoder()
        if let savedItems = try? decoder.decode([HabitsItem].self, from: data) {
            return savedItems
        }

        return []
    }
}

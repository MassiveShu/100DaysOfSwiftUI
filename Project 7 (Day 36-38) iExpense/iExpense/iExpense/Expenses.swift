//
//  Expenses.swift
//  iExpense
//
//  Created by Max Shu on 23.07.2022.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodetItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodetItems
                return
            }
        }
        
        items = []
    }
}

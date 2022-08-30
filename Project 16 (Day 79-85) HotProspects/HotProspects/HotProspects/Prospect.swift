//
//  Prospect.swift
//  HotProspects
//
//  Created by Max Shu on 26.08.2022.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var date = Date.now
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    @Published var sortingOrder: SortingOrder = .nameAscending
    
    
    // save data to UserDefaults
    
//    let saveKey = "SavedData"
//
//    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
//
//        // no saved data!
//        people = []
//    }
    
    // 2. Use JSON and the documents directory for saving and loading our user data.
    
    let saveKey = FileManager.documentsDirectory.appendingPathComponent("SavedData").appendingPathExtension("JSON")
    
    init() {
        do {
            let data = try Data(contentsOf: saveKey)
            let decoded = try JSONDecoder().decode([Prospect].self, from: data)
            people = decoded
        } catch {
            people = []
        }
    }
    
    private func save() {
//        if let encode = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encode, forKey: saveKey)
//        }
        
    // 2.1 Use JSON and the documents directory for saving and loading our user data.
        
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: saveKey, options: [.atomic])
        } catch {
            print("Cannot save data!")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    // 3. Use a confirmation dialog to customize the way users are sorted in each tab – by name or by most recent.
    
    func toggle(_ prospect: SortingOrder) {
        objectWillChange.send()
        sorted(by: sortingOrder)
    }
    
    func sorted(by order: SortingOrder) {
        switch order {
        case .nameAscending:
            people = people.sorted { $0.name < $1.name }
            sortingOrder = .nameAscending
//        case .dateAscending:
//            people = people.sorted { $0.date < $1.date }
//            sortingOrder = .dateAscending        
            }
        }
    }

enum SortingOrder {
    case nameAscending // dateAscending
}

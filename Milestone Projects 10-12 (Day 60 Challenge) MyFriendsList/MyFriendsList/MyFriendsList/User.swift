//
//  User.swift
//  MyFriendsList
//
//  Created by Max Shu on 11.08.2022.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    static let example = User(id: UUID(), isActive: true, name: "some name", age: 32, company: "some company", email: "some mail", address: "some address", about: "about", registered: Date.now, tags: ["Some tags", "Some more tags", "Vodka"], friends: [])
}

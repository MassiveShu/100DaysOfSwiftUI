//
//  Friend.swift
//  MyFriendsList
//
//  Created by Max Shu on 11.08.2022.
//

import Foundation

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}

//
//  Card.swift
//  Flashzilla
//
//  Created by Max Shu on 01.09.2022.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who is who", answer: "Me")
}

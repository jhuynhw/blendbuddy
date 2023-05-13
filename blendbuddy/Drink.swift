//
//  Drink.swift
//  blendbuddy
//
//

import Foundation

struct Drink: Identifiable, Codable {
    let id: UUID
    let name: String
    
    static let example = Drink(id: UUID(), name: "Example Drink")
    
}

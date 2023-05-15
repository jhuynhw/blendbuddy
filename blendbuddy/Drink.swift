//
//  Drink.swift
//  blendbuddy
//
//

import Foundation

struct Drink: Identifiable, Codable {
    let id: UUID
    let name: String
    let sugar: [Int]
    let smoothieBased: Bool
    let servedWithMilk: Bool
    let baseCalories: Int
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "-")
    }
    
    static let example = Drink(id: UUID(), name: "Example Drink", sugar: [15, 25, 30], smoothieBased: true, servedWithMilk: true, baseCalories: 150)
}

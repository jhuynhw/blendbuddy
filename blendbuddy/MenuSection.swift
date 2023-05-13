//
//  MenuSection.swift
//  blendbuddy
//
//

import Foundation

struct MenuSection: Identifiable, Codable {
    let id: UUID
    let name: String
    let drinks: [Drink]
}

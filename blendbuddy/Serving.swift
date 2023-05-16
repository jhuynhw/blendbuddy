//
//  Serving.swift
//  blendbuddy
//
//

import Foundation

struct Serving: Identifiable, Codable {
    var id: UUID
    let name: String
    let description: String
    let sugar: Int
    let calories: Int
}

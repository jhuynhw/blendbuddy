//
//  ConfigurationOption.swift
//  blendbuddy
//
//  Created by Johnathan Huynh on 5/15/23.
//

import Foundation

struct ConfigurationOption: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let calories: Int
    static let none = ConfigurationOption(id: UUID(), name: "None", calories: 0)
}

//
//  History.swift
//  blendbuddy
//
//

import Foundation

class History: ObservableObject {
    @Published var servings: [Serving]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedDrinks")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            servings = try JSONDecoder().decode([Serving].self, from: data)
        }
        catch {
            servings = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(servings)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
        catch {
            print("Unable to save data")
        }
    }
    
    func add(_ drink: Drink, size: String, extraSugar: Int, isZeroSugar: Bool, milk: ConfigurationOption, topping: ConfigurationOption, sugar: Int, calories: Int) {
        var description = [String]()
        description.append(size)
        
        if isZeroSugar {
            description.append("zero sugar")
        }
        
        switch extraSugar {
        case 0:
            break
        case 1:
            description.append("1 tbsp of sugar")
        default:
            description.append("\(extraSugar) tbsp of sugar")
        }
        
        if milk != .none {
            description.append("\(milk.name.lowercased()) milk")
        }
        
        if topping != .none {
            description.append("\(topping.name.lowercased()) topping")
        }
        
        let descriptionString = description.joined(separator: ", ")
        
        let serving = Serving(id: UUID(), name: drink.name, description: descriptionString, sugar: sugar, calories: calories)
        servings.insert(serving, at: 0)
        save()
    }
}

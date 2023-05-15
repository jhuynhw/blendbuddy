//
//  Menu.swift
//  blendbuddy
//
//

import Foundation

class Menu: ObservableObject, Codable {
    let sections: [MenuSection]
    var milkOptions = [ConfigurationOption.none]
    var toppingOptions = [ConfigurationOption.none]
    
    init() {
        do {
            let url = Bundle.main.url(forResource: "menu",withExtension: "json")!
            let data = try Data(contentsOf: url)
            let menuData = try JSONDecoder().decode(Menu.self, from: data)
            
            sections = menuData.sections
            milkOptions.append(contentsOf: menuData.milkOptions)
            toppingOptions.append(contentsOf: menuData.toppingOptions)
        }
        catch {

            fatalError("menu.json cannot be found or is corrupt")
        }
    }
}

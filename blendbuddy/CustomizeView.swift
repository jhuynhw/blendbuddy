//
//  CustomizeView.swift
//  blendbuddy
//
//

import SwiftUI

struct CustomizeView: View {
    let drink: Drink
    
    @EnvironmentObject var menu: Menu
    
    @State private var size = 0
    @State private var isZeroSugar = false
    @State private var extraSugar = 0
    @State private var milk = ConfigurationOption.none
    @State private var topping = ConfigurationOption.none
    
    let sizeOptions = ["Small", "Medium", "Large"]
    
    var sugar: Int {
        100
    }
    
    var calories: Int {
        100
    }
    
    var body: some View {
        Form {
            Section("Basic options") {
                Picker("Size", selection: $size) {
                    ForEach(sizeOptions.indices, id: \.self) { index in
                        Text(sizeOptions[index])
                    }
                }
                .pickerStyle(.segmented)
                
                if drink.smoothieBased {
                    Stepper("Extra Condensed Milk: \(extraSugar)",
                            value: $extraSugar, in: 0...8)
                }
                
                Toggle("Zero Sugar", isOn: $isZeroSugar)
            }
            
            Section("Customizations") {
                Picker("Milk", selection: $milk) {
                    ForEach(menu.milkOptions) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }
            }
            
            if drink.smoothieBased {
                Picker("Topping", selection: $topping) {
                    ForEach(menu.toppingOptions) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }
            }
            
            Section("Estimates") {
                Text("**Sugar:** \(sugar)g")
                Text("**Calories:** \(calories)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(drink.name)
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView(drink: Drink.example)
            .environmentObject(Menu()  )
    }
}

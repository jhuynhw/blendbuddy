//
//  CustomizeView.swift
//  blendbuddy
//
//

import SwiftUI

struct CustomizeView: View {
    let drink: Drink
    let dismiss: () -> Void
    
    @EnvironmentObject var menu: Menu
    @EnvironmentObject var history: History
    
    @State private var size = 0
    @State private var isZeroSugar = false
    @State private var extraSugar = 0
    @State private var milk = ConfigurationOption.none
    @State private var topping = ConfigurationOption.none
    
    let sizeOptions = ["Small", "Medium", "Large"]
    
    var sugar: Int {
        var sugarAmount = drink.sugar[size]
        sugarAmount += (extraSugar * 15)
        
        if isZeroSugar {
            sugarAmount /= 5
        }
        
        return sugarAmount
    }
    
    var calories: Int {
        var calorieAmount = drink.baseCalories
        calorieAmount += extraSugar * 10
        
        if drink.smoothieBased {
            calorieAmount += milk.calories
        }
        else {
            calorieAmount += milk.calories / 8
        }
        
        calorieAmount += topping.calories
        return calorieAmount * (size + 1)
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
                
                if drink.smoothieBased {
                    Picker("Topping", selection: $topping) {
                        ForEach(menu.toppingOptions) { option in
                            Text(option.name)
                                .tag(option)
                        }
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
        .toolbar {
            Button("Save") {
                history.add(drink, size: sizeOptions[size], extraSugar: extraSugar, isZeroSugar: isZeroSugar, milk: milk, topping: topping, sugar: sugar, calories: calories)
                
                dismiss()
            }
        }
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView(drink: Drink.example) {}
            .environmentObject(Menu()  )
    }
}

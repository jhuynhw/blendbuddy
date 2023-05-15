//
//  CustomizeView.swift
//  blendbuddy
//
//

import SwiftUI

struct CustomizeView: View {
    let drink: Drink
    
    @State private var size = 0
    @State private var isZeroSugar = false
    
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
                
                Toggle("Zero Sugar", isOn: $isZeroSugar)
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
    }
}

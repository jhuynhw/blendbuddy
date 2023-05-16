//
//  ContentView.swift
//  blendbuddy
//
//

import SwiftUI

struct ContentView: View {
    @StateObject var menu = Menu()
    @StateObject var history = History()
    @State private var showingAddScreen = false
    
    var totalSugar: Int {
        history.servings.map(\.sugar).reduce(0, +)
    }
    
    var totalCalories: Int {
        history.servings.map(\.calories).reduce(0, +)
    }
    
    var body: some View {
        NavigationView {
            List {
                if history.servings.isEmpty {
                    Button("Add your first drink") {
                        showingAddScreen = true
                    }
                }
                else {
                    Section("Summary") {
                        Text("Sugar: \(totalSugar)g")
                        Text("Calories: \(totalCalories)")
                    }
                    
                    ForEach(history.servings) { serving in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(serving.name)
                                    .font(.headline)
                                
                                Text(serving.description)
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            Text("\(serving.sugar)g")
                        }
                        
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    history.deleteServing(serving)
                                }
                            }
                            label: {
                                    Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                withAnimation {
                                    history.reorderServing(serving)
                                }
                                label: {
                                    Label("Duplicate", systemImage: "duplicate")
                                }
                                .tint(.blue)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen, content: MenuView.init)
            .navigationTitle("BlendBuddy")
            .toolbar {
                Button {
                showingAddScreen = true
                }
                label: {
                    Label("Add New Drink", systemImage: "plus")
                }
            }
        }
            .environmentObject(menu)
            .environmentObject(history)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  MainView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    private let gridLayout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
       var body: some View {
           ScrollView {
               LazyVGrid(columns: gridLayout, spacing: 16) {
                   ForEach(0..<10) { _ in
                       DishesComponentView()
                           .padding(10)
                   }
               }
               .padding()
           }
       }
}

#Preview {
    MainView()
}

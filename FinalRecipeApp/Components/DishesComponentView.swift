//
//  DishesComponentView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 22.01.24.
//

import SwiftUI

struct DishesComponentView: View {
    
    // MARK: - Body
    var body: some View {
        VStack{
            dishesImageView
            nameDishesView
            additionalInfoHStack
        }
    }
}

// MARK: - Components
extension DishesComponentView {
    
    // MARK: - DishesImageView
    private var dishesImageView: some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 120)
    }
    
    // MARK: -NameDishesView
    private var nameDishesView: some View {
        Text("Chorizo & mozzarella gnocchi bake")
            .lineLimit(2)
            .font(.callout)
            .fontWeight(.semibold)
    }
    
    private var additionalInfoHStack: some View {
        HStack {
            caloriesInfoHStack
            prepareTimeHStack
        }
    }
    
    private var caloriesInfoHStack: some View {
        HStack(spacing: 1) {
            Image(systemName: "flame.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 13)
                .frame(width: 11)
            Text("350 Kcal")
                .font(.caption)
                .padding(.horizontal, 5)
        }
    }
    
    private var prepareTimeHStack: some View {
        HStack(spacing: 1) {
            Image(systemName: "clock.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 13)
                .frame(width: 11)
            
            Text("20 min")
                .font(.caption)
                .padding(.horizontal, 5)
        }
    }
}


#Preview {
    DishesComponentView()
}

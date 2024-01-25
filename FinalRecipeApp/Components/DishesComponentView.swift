//
//  DishesComponentView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 22.01.24.
//

import SwiftUI

struct DishesComponentView: View {
    var imageUrl: String
    var name: String
    var calorie: Int
    var prepareTime: Int
    
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
        AsyncImage(url: URL(string: imageUrl))
            .aspectRatio(contentMode: .fill)
            .frame(width: 170,height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    // MARK: -NameDishesView
    private var nameDishesView: some View {
        Text(name)
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
            Text("\(calorie) Kcal")
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
            
            Text("\(prepareTime) min")
                .font(.caption)
                .padding(.horizontal, 5)
        }
    }
}

#Preview {
    DishesComponentView(imageUrl: "photo", name: "Chorizo & mozzarella gnocchi bake", calorie: 350, prepareTime: 20)
}

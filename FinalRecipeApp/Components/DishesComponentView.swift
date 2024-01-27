//
//  DishesComponentView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 22.01.24.
//

import SwiftUI

struct DishesComponentView: View {
    
    
    // MARK: - Properties
    var imageUrl: String
    var name: String
    var calorie: Int
    var prepareTime: Int
    
    // MARK: - Body
    var body: some View {
        VStack{
            dishesImageViewContent
            nameDishesView
            additionalInfoHStack
        }
    }
}

// MARK: - Components
extension DishesComponentView {
    
    // MARK: - Views
    private var dishesImageViewContent: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                dishesImageView(image: nil, isLoading: true)
            case .success(let image):
                dishesImageView(image: image, isLoading: false)
            case .failure:
                dishesImageView(image: Image(systemName: "photo"), isLoading: false)
            @unknown default:
                EmptyView()
            }
        }
    }

    private func dishesImageView(image: Image?, isLoading: Bool) -> some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                Color.clear
                    .frame(width: 150, height: 130) // Set the desired frame for the clear color
            }

            if isLoading {
                ProgressView()
                    .frame(width: 150, height: 130) // Set the same frame as the image
            }
        }
    }

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
                .scaledToFit()
                .frame(width: 11, height: 13)
            Text("\(calorie) Kcal")
                .font(.caption)
                .padding(.horizontal, 5)
        }
    }
    
    private var prepareTimeHStack: some View {
        HStack(spacing: 1) {
            Image(systemName: "clock.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 11, height: 13)
            
            Text("\(prepareTime) min")
                .font(.caption)
                .padding(.horizontal, 5)
        }
    }
}

#Preview {
    DishesComponentView(imageUrl: "photo", name: "Chorizo & mozzarella gnocchi bake", calorie: 350, prepareTime: 20)
}
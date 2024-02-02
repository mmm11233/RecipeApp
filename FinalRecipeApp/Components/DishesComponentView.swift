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
    var favouriteButtonIsHidden: Bool
    
    // MARK: - Body
    var body: some View {
        
        VStack{
            ZStack(alignment: .topTrailing){
                dishesImageViewContent
                if !favouriteButtonIsHidden {
                    heartButton
                        .padding(.trailing, 12)
                        .padding(.top, 12)
                }
            }
            nameDishesView
            additionalInfoHStack
        }
    }
}

// MARK: - Components
extension DishesComponentView {
    
    // MARK: - Views
    private var heartButton: some View {
        Button(action: {
            // Handle heart button tap action
            // Add your logic here
        }) {
            Image("heart")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
        }
        .frame(width: 20, height: 20)
        .background(Color.white)
        .cornerRadius(7.0)
    }
    
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
                    .frame(width: 150, height: 130)
            }
            
            if isLoading {
                ProgressView()
                    .frame(width: 150, height: 130)
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
            Image("fire 3")
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
            Image("clock 2")
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
    DishesComponentView(imageUrl: "photo", name: "Chorizo & mozzarella gnocchi bake", calorie: 350, prepareTime: 20, favouriteButtonIsHidden: false)
}

//
//  DishesComponentView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 22.01.24.
//

import SwiftUI
import Combine

struct DishesComponentView: View {
    
    // MARK: - Properties
    var dish: Dish
    var favouriteButtonIsHidden: Bool
    var favouriteButtonTapPublisher: PassthroughSubject<Dish, Never>? = nil
    @State private var isFavourite: Bool = false
    
    // MARK: - Body
    var body: some View {
        
        VStack(alignment: .center) {
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
        .onAppear {
            fetchFavoriteStatus()
        }
    }
}

// MARK: - Components
extension DishesComponentView {
    
    // MARK: - Views
    private var heartButton: some View {
        Button(action: {
            self.isFavourite.toggle()
            favouriteButtonTapPublisher?.send(dish)
        }) {
            Image(isFavourite ? "heart 1" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
        }
        .frame(width: 20, height: 20)
        .background(Color.white)
        .cornerRadius(7.0)
    }
    
    private var dishesImageViewContent: some View {
        AsyncImage(url: URL(string: dish.pictureURL)) { phase in
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
                    .frame(width: 165, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                Color.clear
                    .frame(width: 165, height: 150)
            }
            
            if isLoading {
                ProgressView()
                    .frame(width: 165, height: 150)
            }
        }
    }
    
    private var nameDishesView: some View {
        Text(dish.name)
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
            Text("\(dish.calories) Kcal")
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
            
            Text("\(dish.preparingTime) min")
                .font(.caption)
                .padding(.horizontal, 5)
        }
    }
    
    private func fetchFavoriteStatus() {
        isFavourite = FavouritesRepository.shared.isDishFavorite(dish: dish)
    }
}

#Preview {
    DishesComponentView(dish: .init(name: "name", pictureURL: "", calories: 23, preparingTime: 12, categoryType: .Breakfast, ingredients: ["das","dsad"], restaurants: []), favouriteButtonIsHidden: false)
}

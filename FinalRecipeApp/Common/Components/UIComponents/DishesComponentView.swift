//
//  DishesComponentView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 22.01.24.
//

import SwiftUI
import Combine

struct DishesComponentViewModel {
    let dish: Dish
    let favouriteButtonIsHidden: Bool
    var favouriteButtonTapPublisher: PassthroughSubject<Dish, Never>? = nil
    
    init(dish: Dish, 
         favouriteButtonIsHidden: Bool,
         favouriteButtonTapPublisher: PassthroughSubject<Dish, Never>? = nil) {
        self.dish = dish
        self.favouriteButtonIsHidden = favouriteButtonIsHidden
        self.favouriteButtonTapPublisher = favouriteButtonTapPublisher
    }
}

struct DishesComponentView: View {
    
    // MARK: - Properties
    var model: DishesComponentViewModel
    @State private var isFavourite: Bool = false
    
    // MARK: - Body
    var body: some View {
        
        VStack(alignment: .center) {
            ZStack(alignment: .topTrailing){
                dishesImageViewContent
                if !model.favouriteButtonIsHidden {
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
        .background(Color("White"))
    }
}

// MARK: - Components
extension DishesComponentView {
    
    // MARK: - Views
    private var heartButton: some View {
        Button(action: {
            self.isFavourite.toggle()
            model.favouriteButtonTapPublisher?.send(model.dish)
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
        AsyncImage(url: URL(string: model.dish.pictureURL)) { phase in
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
        Text(model.dish.name)
            .lineLimit(2)
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundColor(Color("Black"))
    }
    
    private var additionalInfoHStack: some View {
        HStack {
            caloriesInfoHStack
            prepareTimeHStack
        }
    }
    
    private var caloriesInfoHStack: some View {
        HStack(spacing: 1) {
            Image("fire 3").renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 11, height: 13)
                .foregroundColor(Color("Black"))
            Text("\(model.dish.calories) Kcal")
                .font(.caption)
                .padding(.horizontal, 5)
                .foregroundColor(Color("Black"))
        }
    }
    
    private var prepareTimeHStack: some View {
        HStack(spacing: 1) {
            Image("clock 2").renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 11, height: 13)
                .foregroundColor(Color("Black"))
            Text("\(model.dish.preparingTime) min")
                .font(.caption)
                .padding(.horizontal, 5)
                .foregroundColor(Color("Black"))
        }
    }
    
    private func fetchFavoriteStatus() {
        isFavourite = FavouritesRepository.shared.isDishFavorite(dish: model.dish)
    }
}

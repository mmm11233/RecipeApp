//
//  DishComponentView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 22.01.24.
//

import SwiftUI
import Combine

struct DishComponentViewModel {
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

struct DishComponentView: View {
    
    // MARK: - Properties
    var model: DishComponentViewModel
    @State private var isFavourite: Bool = false
    
    // MARK: - Body
    var body: some View {
        
        VStack(alignment: .center) {
            ZStack(alignment: .topTrailing){
                dishImageViewContent
                if !model.favouriteButtonIsHidden {
                    heartButton
                        .padding(.trailing, 12)
                        .padding(.top, 12)
                }
            }
            nameView
            additionalInfoes
        }
        .onAppear {
            fetchFavoriteStatus()
        }
        .background(Color(ColorBook.white))
    }
}

// MARK: - Components
extension DishComponentView {
    
    // MARK: - Views
    private var heartButton: some View {
        Button(action: {
            self.isFavourite.toggle()
            model.favouriteButtonTapPublisher?.send(model.dish)
        }) {
            Image(uiImage: isFavourite ? ImageBook.Icons.heartFill : ImageBook.Icons.heart)
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
        }
        .frame(width: 20, height: 20)
        .background(Color(ColorBook.white))
        .cornerRadius(7.0)
    }
    
    private var dishImageViewContent: some View {
        AsyncImage(url: URL(string: model.dish.pictureURL)) { phase in
            switch phase {
            case .empty:
                dishImageView(image: nil, isLoading: true)
            case .success(let image):
                dishImageView(image: image, isLoading: false)
            case .failure:
                dishImageView(image: Image(uiImage: ImageBook.Images.defaultPhoto), isLoading: false)
            @unknown default:
                EmptyView()
            }
        }
    }
    
    private func dishImageView(image: Image?, isLoading: Bool) -> some View {
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
    
    private var nameView: some View {
        Text(model.dish.name)
            .lineLimit(2)
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundColor(Color(ColorBook.black))
    }
    
    private var additionalInfoes: some View {
        HStack {
            caloriesInfo
            prepareTime
        }
    }
    
    private var caloriesInfo: some View {
        HStack(spacing: 1) {
            Image(uiImage: ImageBook.Icons.fire).renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 11, height: 13)
                .foregroundColor(Color(ColorBook.black))
            Text("\(model.dish.calories) Kcal")
                .font(.caption)
                .padding(.horizontal, 5)
                .foregroundColor(Color(ColorBook.black))
        }
    }
    
    private var prepareTime: some View {
        HStack(spacing: 1) {
            Image(uiImage: ImageBook.Icons.clock).renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 11, height: 13)
                .foregroundColor(Color(ColorBook.black))
            Text("\(model.dish.preparingTime) min")
                .font(.caption)
                .padding(.horizontal, 5)
                .foregroundColor(Color(ColorBook.black))
        }
    }
    
    private func fetchFavoriteStatus() {
        isFavourite = FavouritesRepository.shared.isDishFavorite(dish: model.dish)
    }
}

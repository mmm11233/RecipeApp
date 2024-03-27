//
//  DishComponentModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 27.03.24.
//

import Foundation
import Combine

// MARK: - Dish View Model
struct DishComponentModel {
    // MARK: Properties
    let dish: Dish
    let favouriteButtonIsHidden: Bool
    var favouriteButtonTapPublisher: PassthroughSubject<Dish, Never>? = nil
    
    // MARK: Initalizer
    init(dish: Dish,
         favouriteButtonIsHidden: Bool,
         favouriteButtonTapPublisher: PassthroughSubject<Dish, Never>? = nil) {
        self.dish = dish
        self.favouriteButtonIsHidden = favouriteButtonIsHidden
        self.favouriteButtonTapPublisher = favouriteButtonTapPublisher
    }
}

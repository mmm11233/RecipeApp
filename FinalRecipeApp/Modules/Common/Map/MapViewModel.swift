//
//  MapViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 06.02.24.
//

import Foundation
import CoreLocation

// MARK: Map View Model
protocol MapViewModel {
    var restaurants: [Restaurant] { get }
}

// MARK: Map View Model Impl
final class MapViewModelImpl: MapViewModel {
    
    // MARK: Properties
    var restaurants: [Restaurant] {
        dish.restaurants
    }
    
    private let dish: Dish
    
    // MARK: - Initializer
    init(dish: Dish) {
        self.dish = dish
    }
}

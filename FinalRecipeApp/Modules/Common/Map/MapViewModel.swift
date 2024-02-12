//
//  MapViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 06.02.24.
//

import Foundation
import CoreLocation

protocol MapViewModel {
    var restaurants: [Restaurant] { get }
}

final class MapViewModelImpl: MapViewModel {
    
    // MARK: - Properties
    private let dish: Dish
    
    // MARK: - Init
    init(dish: Dish) {
        self.dish = dish
    }
    
    var restaurants: [Restaurant] {
        dish.restaurants
    }
}

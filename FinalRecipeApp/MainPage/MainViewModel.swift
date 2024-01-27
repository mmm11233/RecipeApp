//
//  MainViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import UIKit
import NetSwift

final class MainViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var dishes: [Dish] = []
    @Published var searchText: String = ""
    
    var filteredDishes: [Dish] {
        guard !searchText.isEmpty else { return dishes }
        return dishes.filter { dish in
            dish.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    //MARK: - Init
    init() {
        fetchDishes()
    }
    
    //MARK: - Methods
    func fetchDishes() {
        DishesManager.shared.fetchDishes(completion: { [weak self] result in
            switch result {
            case .success(let dishes):
                self?.dishes = dishes
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
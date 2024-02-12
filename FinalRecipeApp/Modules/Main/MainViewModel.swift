//
//  MainViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import UIKit
import NetSwift
import CoreData
import Combine

final class MainViewModel: ObservableObject {
    
    //MARK: - Properties
    private var subscribers = Set<AnyCancellable>()
    
    private let dishesService: DishesService
    @Published var dishes: [Dish] = []
    @Published var searchText: String = ""
        
    var filteredDishes: [Dish] {
        guard !searchText.isEmpty else { return dishes }
        return dishes.filter { dish in
            dish.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var favouriteButtonTapPublisher: PassthroughSubject<Dish, Never> = .init()
    
    //MARK: - Init
    init(dishesService: DishesService) {
        self.dishesService = dishesService
        setupBindigs()
        fetchDishes()
    }
    
    // MARK: - Requests
    private func setupBindigs() {
        favouriteButtonTapPublisher
            .sink { dish in
                let existingDishes = FavouritesRepository.shared.fetchDishes()
                
                if !existingDishes.contains(where: { $0.name == dish.name }) {
                    FavouritesRepository.shared.saveDish(dish: dish)
                } else {
                    FavouritesRepository.shared.deleteDish(dishID: dish.id)
                }
            }.store(in: &subscribers)
    }
    
    func fetchDishes() {
        dishesService.fetchDishes(completion: { [weak self] result in
            switch result {
            case .success(let dishes):
                self?.dishes = dishes
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

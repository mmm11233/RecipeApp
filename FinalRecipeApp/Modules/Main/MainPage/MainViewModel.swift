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
    
    private var dishesService: DishesService
    @Published var dishes: [Dish] = []
    @Published var searchText: String = ""
    
    var managedObjectContext: NSManagedObjectContext?
    
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
    
    private func setupBindigs() {
        favouriteButtonTapPublisher
            .sink { [weak self] dish in
                print("dasdadasa: ", dish.name)
            }.store(in: &subscribers)
    }
    
    //MARK: - Methods
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

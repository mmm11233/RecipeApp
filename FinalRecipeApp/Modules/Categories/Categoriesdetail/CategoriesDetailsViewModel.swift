//
//  CategoriesDetailsViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//

import Foundation
import Combine

protocol CategoriesDetailsViewModel {
    var dishesDidLoad: PassthroughSubject<Void, Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }

    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func item(at index: Int) -> Dish
}

final class CategoriesDetailsViewModelImpl: CategoriesDetailsViewModel {
    
    //MARK: - Properties
    private var dishes: [Dish] = []
    var dishesDidLoad: PassthroughSubject<Void, Never> = .init()
    var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    
    private var dishesService: DishesService
    
    init(dishesService: DishesService) {
        self.dishesService = dishesService
    }
    
    // MARK: Methods
    func viewDidLoad() {
        fetchDishes()
    }
    
    func numberOfItemsInSection() -> Int {
        dishes.count
    }
    
    func item(at index: Int) -> Dish {
        return dishes[index]
    }

    //MARK: - Methods
    func fetchDishes() {
        isLoading.send(true)
        
        dishesService.fetchDishes(completion: { [weak self] result in
            guard let self else { return }
            isLoading.send(false)

            switch result {
            case .success(let dishes):
                self.dishes = dishes
                dishesDidLoad.send()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

//
//  CategoriesDetailsViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//

import Foundation
import Combine
import CoreData
import UIKit

protocol CategoriesDetailsViewModel {
    var dishesDidLoad: PassthroughSubject<Void, Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var favouriteButtonTapPublisher: PassthroughSubject<Dish, Never> { get }

    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
    func item(at index: Int) -> Dish
}

final class CategoriesDetailsViewModelImpl: CategoriesDetailsViewModel {
    
    //MARK: - Properties
    private var subscribers = Set<AnyCancellable>()

    var dishesDidLoad: PassthroughSubject<Void, Never> = .init()
    var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    var favouriteButtonTapPublisher: PassthroughSubject<Dish, Never> = .init()
    
    private var dishesService: DishesService
    private var fileteredType: CategoryType
    
    private var _dishes: [Dish] = []
    private var dishes: [Dish] {
        get {
            _dishes.filter({ $0.categoryType == fileteredType })
        }
        set {
            _dishes = newValue
        }
    }
    
    //MARK: - Init
    init(dishesService: DishesService,
         fileteredType: CategoryType) {
        self.dishesService = dishesService
        self.fileteredType = fileteredType
        setupBindings()
    }
    
    //MARK: - Methods
    func viewDidLoad() {
        fetchDishes()
    }
    
    func numberOfItemsInSection() -> Int {
        dishes.count
    }
    
    func item(at index: Int) -> Dish {
        return dishes[index]
    }
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController) {
        let vc = DetailsViewController()
        vc.viewModel = DetailsViewModelImpl(selectedDish: dishes[index])
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupBindings() {
        favouriteButtonTapPublisher
            .sink { [weak self] dish in
                guard let self = self else { return }
                
                let existingDishes = FavouritesRepository.shared.fetchDishes()
                
                if !existingDishes.contains(where: { $0.name == dish.name }) {
                    FavouritesRepository.shared.saveDish(dish: dish)
                } else {
                    FavouritesRepository.shared.deleteDish(dish: dish)
                }
            }.store(in: &subscribers)

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

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

// MARK: - Categories Details View Model
protocol CategoriesDetailsViewModel {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var dishesDidLoadPublisher: AnyPublisher<Void, Never> { get }
    var favouriteButtonTapSubject: PassthroughSubject<Dish, Never> { get }
    
    var selectedCategoryType: CategoryType {get set}
    
    func viewDidLoad()
    
    func reloadData()
    func numberOfItemsInSection() -> Int
    func item(at index: Int) -> Dish
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
}

// MARK: - Categories Details View Model Impl
final class CategoriesDetailsViewModelImpl: CategoriesDetailsViewModel {
    //MARK: Properties
    private var subscribers = Set<AnyCancellable>()
    
    private let isLoadingSubject: CurrentValueSubject<Bool, Never> = .init(false)
    var isLoading: AnyPublisher<Bool, Never> { isLoadingSubject.eraseToAnyPublisher() }

    private let dishesDidLoadSubject: PassthroughSubject<Void, Never> = .init()
    var dishesDidLoadPublisher: AnyPublisher<Void, Never> { dishesDidLoadSubject.eraseToAnyPublisher() }
   
    var favouriteButtonTapSubject: PassthroughSubject<Dish, Never> = .init()

    var selectedCategoryType: CategoryType
    
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
    
    //MARK: Initializers
    init(dishesService: DishesService,
         fileteredType: CategoryType) {
        self.dishesService = dishesService
        self.fileteredType = fileteredType
        self.selectedCategoryType = fileteredType
        setupBindings()
    }
    
    // MARK: Life Cycle
    func viewDidLoad() {
        fetchDishes()
    }
    
    // MARK: Data Source Methods
    func reloadData() {
        fetchDishes()
    }
    
    func numberOfItemsInSection() -> Int {
        dishes.count
    }
    
    func item(at index: Int) -> Dish {
        dishes[index]
    }
    
    // MARK: User Interaction
    func didSelectRowAt(at index: Int, from viewController: UIViewController) {
        let vc = DetailsViewController(viewModel: DetailsViewModelImpl(selectedDish: dishes[index], mapButtonIsHidden: false))
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Request
    private func setupBindings() {
        favouriteButtonTapSubject
            .sink { dish in
                let existingDishes = FavouritesRepository.shared.fetchDishes()
                
                if !existingDishes.contains(where: { $0.name == dish.name }) {
                    FavouritesRepository.shared.saveDish(dish: dish)
                } else {
                    FavouritesRepository.shared.deleteDish(dishID: dish.id)
                }
            }.store(in: &subscribers)
    }
    
    private func fetchDishes() {
        isLoadingSubject.send(true)
        
        dishesService.fetchDishes(completion: { [weak self] result in
            guard let self else { return }
            isLoadingSubject.send(false)
            
            switch result {
            case .success(let dishes):
                self.dishes = dishes
                dishesDidLoadSubject.send()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

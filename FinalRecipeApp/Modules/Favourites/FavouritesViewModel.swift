//
//  FavouritesViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 02.02.24.
//
import Foundation
import UIKit
import CoreData
import Combine

protocol FavouritesViewModel {
    var favouriteButtonTapPublisher: PassthroughSubject<Dish, Never> { get }
    
    func viewDidLoad()
    func updateDataSource()
    
    func numberOfItemsInSection() -> Int
    func item(at index: Int) -> Dish
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
}

final class FavouritesViewModelImpl: FavouritesViewModel {
    
    //MARK: - Properties
    var favouriteButtonTapPublisher: PassthroughSubject<Dish, Never> = .init()
    private var subscribers = Set<AnyCancellable>()
    private var dishes: [Dish] = []
    
    //MARK: - Methods
    func viewDidLoad() {
        updateDataSource()
        setupBindings()
    }
    
    private func setupBindings() {
        favouriteButtonTapPublisher
            .sink { dish in
                FavouritesRepository.shared.deleteDish(dishID: dish.id)
            }.store(in: &subscribers)
    }
    
    func updateDataSource() {
        dishes = FavouritesRepository.shared.fetchDishes()
    }
    
    func numberOfItemsInSection() -> Int {
        return dishes.count
    }
    
    func item(at index: Int) -> Dish {
        dishes[index]
    }
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController) {
        let vc  = DetailsViewController(viewModel: DetailsViewModelImpl(selectedDish: dishes[index], mapButtonIsHidden: true))
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

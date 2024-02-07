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
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
    func item(at index: Int) -> Dish
}

final class FavouritesViewModelImpl: FavouritesViewModel {
    var favouriteButtonTapPublisher: PassthroughSubject<Dish, Never> = .init()
    
    private var subscribers = Set<AnyCancellable>()
    
    private var dishes: [Dish] = []
    
    func viewDidLoad() {
        updateDataSource()
        setupBindings()
    }
    
    private func setupBindings() {
        favouriteButtonTapPublisher
            .sink { dish in
                FavouritesRepository.shared.deleteDish(dish: dish)
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
        let dish = dishes[index]
        
        let vc  = DetailsViewController()
        vc.viewModel = DetailsViewModelImpl(selectedDish: dish)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

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
    func viewDidLoad()
    func updateDataSource()
    
    func numberOfItemsInSection() -> Int
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
    func item(at index: Int) -> Dish
}

final class FavouritesViewModelImpl: FavouritesViewModel {
    private var dishes: [Dish] = []
    
    func viewDidLoad() {
        updateDataSource()
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
        vc.viewModel = DetailsViewModel(selectedDish: dish)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

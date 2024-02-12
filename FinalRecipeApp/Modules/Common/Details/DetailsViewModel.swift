//
//  DetailsViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//

import UIKit

protocol DetailsViewModel {
    var selectedDish: Dish { get }
    var mapButtonIsHidden: Bool { get }
    
    func getTitle() -> String
    func getSubTitle() -> String
    func getDescription() -> String
    func mapButtonTapped(from viewController: UIViewController)
}

class DetailsViewModelImpl: DetailsViewModel {
    
    // MARK: - Properties
    var selectedDish: Dish
    var mapButtonIsHidden: Bool
    // MARK: - Init
    init(selectedDish: Dish, mapButtonIsHidden: Bool) {
        self.selectedDish = selectedDish
        self.mapButtonIsHidden = mapButtonIsHidden
    }
    
    // MARK: - Methods
    func getTitle() -> String {
        selectedDish.name
    }
    
    func getSubTitle() -> String {
        "\(selectedDish.calories) Kcal - \(selectedDish.preparingTime) min"
    }
    
    func getDescription() -> String {
        selectedDish.ingredients.joined(separator: ", ")
    }
    
    func mapButtonTapped(from viewController: UIViewController) {
        let vc  = MapViewController(viewModel: MapViewModelImpl(dish: selectedDish))
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

//
//  DetailsViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//

import UIKit

// MARK: - Details View Model
protocol DetailsViewModel {
    var selectedDish: Dish { get }
    var mapButtonIsHidden: Bool { get }
    
    func getTitle() -> String
    func getSubTitle() -> String
    func getDescription() -> String
    func mapButtonTapped(from viewController: UIViewController)
    
    func downloadImage(from url: URL,  completion: @escaping (UIImage?) -> Void)
}

// MARK: - Details View Model Impl
final class DetailsViewModelImpl: DetailsViewModel {
    // MARK: Properties
    var selectedDish: Dish
    var mapButtonIsHidden: Bool
    
    // MARK: Initializer
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
    
    // MARK: User Interaction
    func mapButtonTapped(from viewController: UIViewController) {
        let vc  = MapViewController(viewModel: MapViewModelImpl(dish: selectedDish))
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Request
    func downloadImage(from url: URL,  completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                completion((UIImage(data: data)))
            }
            completion(nil)
        }.resume()
    }
}

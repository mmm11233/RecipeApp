//
//  CategoriesViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 21.01.24.
//

import UIKit

protocol CategoriesViewModel {
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func item(at index: Int) -> Category
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
}

final class CategoriesViewModelImpl: CategoriesViewModel {
    
    // MARK: - Properties
    private var categories: [Category] = []
    
    func viewDidLoad() {
        setupCategories()
    }
    
    func numberOfRowsInSection() -> Int {
        categories.count
    }
    
    func item(at index: Int) -> Category {
        categories[index]
    }
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController) {
        let vc = CategoriesDetailsViewController()
        vc.viewModel = CategoriesDetailsViewModelImpl()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private Methods
    private func setupCategories() {
        self.categories = [
            Category(
                name: "Breakfast",
                image: UIImage(named: "image 1")!),
            Category(
                name: "Lunch",
                image: UIImage(named: "image 3")!),
            Category(
                name: "Drinks",
                image: UIImage(named: "image 4")!),
            Category(
                name: "Pastas",
                image: UIImage(named: "image 5")!),
            Category(
                name: "Salads",
                image: UIImage(named: "image 6")!),
            Category(
                name: "Desserts",
                image: UIImage(named: "image 7")!),
            Category(
                name: "Soups",
                image: UIImage(named: "image 2")!),
        ]
    }
}

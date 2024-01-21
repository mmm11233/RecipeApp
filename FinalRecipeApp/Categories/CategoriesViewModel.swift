//
//  CategoriesViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 21.01.24.
//

import UIKit

final class CategoriesViewModel {
    var categories: [Category] = []
    
    init() {
        setupCategories()
    }
    
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

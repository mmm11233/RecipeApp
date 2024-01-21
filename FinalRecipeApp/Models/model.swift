//
//  model.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.01.24.
//

import UIKit
class Categories {
    let name: String
    let image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    static let dummyData = [
        Categories(
            name: "Breakfast",
            image: UIImage(named: "image 1")!),
        Categories(
            name: "Lunch",
            image: UIImage(named: "image 3")!),
        Categories(
            name: "Drinks",
            image: UIImage(named: "image 4")!),
        Categories(
            name: "Pastas",
            image: UIImage(named: "image 5")!),
        Categories(
            name: "Salads",
            image: UIImage(named: "image 6")!),
        Categories(
            name: "Desserts",
            image: UIImage(named: "image 7")!),
        Categories(
            name: "Soups",
            image: UIImage(named: "image 2")!),
    ]
}


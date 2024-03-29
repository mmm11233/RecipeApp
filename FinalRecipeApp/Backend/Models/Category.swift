//
//  model.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.01.24.
//

import UIKit

// MARK: - Category Type
enum CategoryType: String, Decodable {
    case Breakfast
    case Lunch
    case Drinks
    case Pastas
    case Salads
    case Desserts
    case Soups
    
    var image: UIImage {
        switch self {
        case .Breakfast: ImageBook.Icons.breakfast
        case .Lunch: ImageBook.Icons.lunch
        case .Drinks: ImageBook.Icons.drinks
        case .Pastas: ImageBook.Icons.pastas
        case .Salads: ImageBook.Icons.salads
        case .Desserts: ImageBook.Icons.desserts
        case .Soups: ImageBook.Icons.soups
        }
    }
}

// MARK: - Category
struct Category: Decodable {
    let type: CategoryType
}

// MARK: Category Response Model
struct CategoryResponseModel: Decodable {
    let categories: [Category]
}

//
//  model.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.01.24.
//

import UIKit

enum CategoryType: String, Decodable {
    case Breakfast
    case Lunch
    case Drinks
    case Pastas
    case Salads
    case Deserts
    case Soups
    
    var image: UIImage {
        switch self {
        case .Breakfast: UIImage(named: "breakfast")!
        case .Lunch: UIImage(named: "lunch")!
        case .Drinks: UIImage(named: "drinks")!
        case .Pastas: UIImage(named: "pastas")!
        case .Salads: UIImage(named: "salads")!
        case .Deserts: UIImage(named: "desserts")!
        case .Soups: UIImage(named: "soups")!
        }
    }
}

struct Category: Decodable {
    let type: CategoryType
    let categoryURL: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case categoryURL = "category_url"
    }
}

struct CategoryResponseModel: Decodable {
    let categories: [Category]
}

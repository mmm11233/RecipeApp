//
//  DishModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import UIKit

struct DisheData: Decodable {
    let dishes: [Dish]
}

struct Dish: Decodable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    let pictureURL: String
    let calories: Int
    let preparingTime: Int
    let category: String
    let ingredients: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case pictureURL = "picture_url"
        case calories
        case preparingTime = "preparing_time"
        case category
        case ingredients
    }
}

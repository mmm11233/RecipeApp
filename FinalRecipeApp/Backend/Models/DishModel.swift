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

struct Restaurant: Decodable, Hashable {
    let name: String
    let rating: Double
    let latitude: Double
    let longitude: Double
}

struct Dish: Decodable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    let pictureURL: String
    let calories: Int
    let preparingTime: Int
    let categoryType: CategoryType
    let ingredients: [String]
    let restaurants: [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case name
        case pictureURL = "picture_url"
        case calories
        case preparingTime = "preparing_time"
        case categoryType = "category"
        case ingredients
        case restaurants
    }
    
    static var mock: Self {
        .init(name: "name",
              pictureURL: "",
              calories: 0,
              preparingTime: 0,
              categoryType: .Breakfast,
              ingredients: ["pasta", "cheese"], 
              restaurants: [])
    }
}

extension Recipe {
    func toDishModel() -> Dish {
        Dish(name: name ?? "",
             pictureURL: pictureURL ?? "",
             calories: Int(calorie),
             preparingTime: Int(preparingTime),
             categoryType: .Breakfast,
             ingredients: [], 
             restaurants: []
        )
    }
}

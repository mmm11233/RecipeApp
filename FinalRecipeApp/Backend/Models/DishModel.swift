//
//  DishModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import UIKit

// MARK: - DishesResponse
struct DisheData: Decodable {
    let dishes: [Dish]
}

// MARK: - Restaurant
struct Restaurant: Decodable, Hashable {
    let name: String
    let rating: Double
    let latitude: Double
    let longitude: Double
}

// MARK: - Dish
struct Dish: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let pictureURL: String
    let calories: Int
    let preparingTime: Int
    let categoryType: CategoryType
    let ingredients: [String]
    let restaurants: [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pictureURL = "picture_url"
        case calories
        case preparingTime = "preparing_time"
        case categoryType = "category"
        case ingredients
        case restaurants
    }
    
    // MARK: - Mock
    static var mock: Self {
        .init(id: "21312",
              name: "name",
              pictureURL: "",
              calories: 0,
              preparingTime: 0,
              categoryType: .Breakfast,
              ingredients: ["pasta", "cheese"], 
              restaurants: [])
    }
}

// MARK: - Extensions
extension Recipe {
    func toDishModel() -> Dish {
        Dish(id: id ?? UUID().uuidString,
             name: name ?? "",
             pictureURL: pictureURL ?? "",
             calories: Int(calorie),
             preparingTime: Int(preparingTime),
             categoryType: .Breakfast,
             ingredients: [], 
             restaurants: []
        )
    }
}

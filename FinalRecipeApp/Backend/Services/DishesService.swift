//
//  DishesService.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import Foundation
import NetSwift

protocol DishesService {
    func fetchDishes(completion: @escaping (Result<[Dish], Error>) -> Void)
}

class DishesServiceImpl: DishesService {
    
    func fetchDishes(completion: @escaping (Result<[Dish], Error>) -> Void) {
        let urlString = "https://raw.githubusercontent.com/mmm11233/RecipesAppMockData/main/dishes"
        guard let URL = URL(string: urlString) else { return }
        
        NetworkManager.shared.fetchDecodableData(from: URL, responseType: DisheData.self, completion: {
            result in
            switch result {
            case .success(let data):
                completion(.success(data.dishes))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

//
//  DishesService.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import Foundation
import NetSwift

// MARK: Dishes Service
protocol DishesService {
    func fetchDishes(completion: @escaping (Result<[Dish], Error>) -> Void)
}

// MARK: Dishes Service Impl
final class DishesServiceImpl: DishesService {
    func fetchDishes(completion: @escaping (Result<[Dish], Error>) -> Void) {
        let urlString = "\(Constants.baseAPIURL)/main/dishes"
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

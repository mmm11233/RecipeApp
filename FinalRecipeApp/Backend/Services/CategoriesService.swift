//
//  CategoriesService.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//

import Foundation
import NetSwift

protocol CategoriesService {
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void)
}

class CategoriesServiceImpl: CategoriesService {
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        let urlString = "https://raw.githubusercontent.com/mmm11233/RecipesAppMockData/main/categories.json"
        guard let URL = URL(string: urlString) else { return }
        
        NetworkManager.shared.fetchDecodableData(from: URL, responseType: CategoryResponseModel.self, completion: {
            result in
            switch result {
            case .success(let data):
                completion(.success(data.categories))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

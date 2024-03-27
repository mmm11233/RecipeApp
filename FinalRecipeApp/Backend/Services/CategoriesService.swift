//
//  CategoriesService.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//

import Foundation
import NetSwift

// MARK: Categories Service
protocol CategoriesService {
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void)
}

// MARK: Categories Service Impl
final class CategoriesServiceImpl: CategoriesService {
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        let urlString = "\(Constants.baseAPIURL)/main/categories.json"
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

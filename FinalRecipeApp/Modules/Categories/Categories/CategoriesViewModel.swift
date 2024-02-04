//
//  CategoriesViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 21.01.24.
//

import UIKit
import Combine

protocol CategoriesViewModel {
    var categoriesDidLoad: PassthroughSubject<Void, Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func item(at index: Int) -> Category
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
}

final class CategoriesViewModelImpl: CategoriesViewModel {
    
    // MARK: - Properties
    private var categoriesService: CategoriesService
    
    private var categories: [Category] = []
    var categoriesDidLoad: PassthroughSubject<Void, Never> = .init()
    var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    
    init(categoriesService: CategoriesService) {
        self.categoriesService = categoriesService
    }
    
    // MARK: Methods
    func viewDidLoad() {
        fetchCategories()
    }
    
    func numberOfRowsInSection() -> Int {
        categories.count
    }
    
    func item(at index: Int) -> Category {
        categories[index]
    }
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController) {
        let vc = CategoriesDetailsViewController()
        vc.viewModel = CategoriesDetailsViewModelImpl(dishesService: DishesServiceImpl())
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private Methods
    private func fetchCategories() {
        isLoading.send(true)
        
        categoriesService.fetchCategories(completion: { [weak self] result in
            self?.isLoading.send(false)
            
            switch result {
            case .success(let categories):
                self?.categories = categories
                self?.categoriesDidLoad.send()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

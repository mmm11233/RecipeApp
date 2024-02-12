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
    var categoriesDidLoad: PassthroughSubject<Void, Never> = .init()
    var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    
    private var categories: [Category] = []
    private var categoriesService: CategoriesService

    // MARK: - Init
    init(categoriesService: CategoriesService) {
        self.categoriesService = categoriesService
    }
    
    // MARK: - Methods
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
        let viewModel = CategoriesDetailsViewModelImpl(dishesService: DishesServiceImpl(), fileteredType: categories[index].type)
        let vc = CategoriesDetailsViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Requests
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

//
//  CategoriesViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 21.01.24.
//

import UIKit
import Combine

protocol CategoriesViewModel {
    var categoriesDidLoadPublisher: AnyPublisher<Void, Never>  { get }
    var isLoading: AnyPublisher<Bool, Never> { get }
    
    func viewDidLoad()
    func refreshData()
    func numberOfRowsInSection() -> Int
    func item(at index: Int) -> Category
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
}

final class CategoriesViewModelImpl: CategoriesViewModel {
    
    // MARK: - Properties
    private let categoriesDidLoadSubject: PassthroughSubject<Void, Never> = .init()
    var categoriesDidLoadPublisher: AnyPublisher<Void, Never> { categoriesDidLoadSubject.eraseToAnyPublisher() }

    private let isLoadingSubject: CurrentValueSubject<Bool, Never> = .init(false)
    var isLoading: AnyPublisher<Bool, Never> { isLoadingSubject.eraseToAnyPublisher() }

    
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
    
    func refreshData() {
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
        isLoadingSubject.send(true)
        
        categoriesService.fetchCategories(completion: { [weak self] result in
            self?.isLoadingSubject.send(false)
            
            switch result {
            case .success(let categories):
                self?.categories = categories
                self?.categoriesDidLoadSubject.send()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

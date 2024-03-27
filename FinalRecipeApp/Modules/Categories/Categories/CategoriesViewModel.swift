//
//  CategoriesViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 21.01.24.
//

import UIKit
import Combine

// MARK: Categories View Model
protocol CategoriesViewModel {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var categoriesDidLoadPublisher: AnyPublisher<Void, Never>  { get }
    
    func viewDidLoad()
    
    func refreshData()
    func numberOfRowsInSection() -> Int
    func item(at index: Int) -> Category
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
}

// MARK: - Categories View Model Impl
final class CategoriesViewModelImpl: CategoriesViewModel {
    // MARK: Properties
    private let isLoadingSubject: CurrentValueSubject<Bool, Never> = .init(false)
    var isLoading: AnyPublisher<Bool, Never> { isLoadingSubject.eraseToAnyPublisher() }
   
    private let categoriesDidLoadSubject: PassthroughSubject<Void, Never> = .init()
    var categoriesDidLoadPublisher: AnyPublisher<Void, Never> { categoriesDidLoadSubject.eraseToAnyPublisher() }
    
    private var categories: [Category] = []
    private var categoriesService: CategoriesService
    
    // MARK: Initializer
    init(categoriesService: CategoriesService) {
        self.categoriesService = categoriesService
    }
    
    // MARK: Life Cycle
    func viewDidLoad() {
        fetchCategories()
    }
    
    // MARK: Methods
    func refreshData() {
        fetchCategories()
    }
    
    func numberOfRowsInSection() -> Int {
        categories.count
    }
    
    func item(at index: Int) -> Category {
        categories[index]
    }
    
    // MARK: User Interaction
    func didSelectRowAt(at index: Int, from viewController: UIViewController) {
        let viewModel = CategoriesDetailsViewModelImpl(dishesService: DishesServiceImpl(), fileteredType: categories[index].type)
        let vc = CategoriesDetailsViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Request
    private func fetchCategories() {
        isLoadingSubject.send(true)
        
        categoriesService.fetchCategories(completion: { [weak self] result in
            guard let self else { return }
            
            isLoadingSubject.send(false)
            
            switch result {
            case .success(let categories):
                self.categories = categories
                categoriesDidLoadSubject.send()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

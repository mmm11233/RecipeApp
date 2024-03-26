//
//  ShoppingListViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 24.03.24.
//

import UIKit
import Combine

protocol ShoppingListViewModel {
    var itemsDidUpdatePublisher: AnyPublisher<Void, Never> { get }
    var noEntriesFoundPublisher: AnyPublisher<String?, Never> { get }
    
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func item(at index: Int) -> String
    func save(item: String)
    func update(indexPath: IndexPath, newValue: String)
    func delete(indexPath: IndexPath)
}

final class ShoppingListViewModelImpl: ShoppingListViewModel {
    
    // MARK: - Properties
    private let itemsDidUpdateSubject: PassthroughSubject<Void, Never> = .init()
    var itemsDidUpdatePublisher: AnyPublisher<Void, Never> { itemsDidUpdateSubject.eraseToAnyPublisher() }
    
    private let noEntriesFountSubject: PassthroughSubject<String?, Never> = .init()
    var noEntriesFoundPublisher: AnyPublisher<String?, Never> { noEntriesFountSubject.eraseToAnyPublisher() }

    private var shoppingItems: [String] = []
    
    // MARK: - Methods
    func viewDidLoad() {
        fetchShoppingItems()
    }
    
    func numberOfRowsInSection() -> Int {
        shoppingItems.count
    }
    
    func item(at index: Int) -> String {
        shoppingItems[index]
    }
    
    func save(item: String) {
        ShoppingRepository.shared.saveShoppingItem(
            item: item,
            success: { [weak self] in
                self?.fetchShoppingItems()
            })
    }
    
    func update(indexPath: IndexPath, newValue: String) {
        let oldValue = item(at: indexPath.row)

        if oldValue != newValue {
            ShoppingRepository.shared.updateItem(oldItem: oldValue,
                                                 newItem: newValue,
                                                 success: { [weak self] in
                self?.fetchShoppingItems()
            })
        }
    }
    
    func delete(indexPath: IndexPath) {
        let item = item(at: indexPath.row)
        
        ShoppingRepository.shared.deleteItem(
            item: item,
            success: { [weak self] in
                self?.fetchShoppingItems()
            })
    }

    private func fetchShoppingItems() {
        shoppingItems = ShoppingRepository.shared.fetchItems()
        itemsDidUpdateSubject.send()
        
        shoppingItems.isEmpty ? noEntriesFountSubject.send("There is no items") : nil
    }
}

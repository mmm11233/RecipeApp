//
//  ShoppingListViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 24.03.24.
//

import UIKit
import Combine

// MARK: Shopping List View Model
protocol ShoppingListViewModel {
    var itemsDidUpdatePublisher: AnyPublisher<Void, Never> { get }
    var noEntriesFoundPublisher: AnyPublisher<String?, Never> { get }
    var moveTableViewRowPublisher: AnyPublisher<(IndexPath, IndexPath), Never> { get }
    
    func viewDidLoad()
    
    func numberOfRowsInSection() -> Int
    func item(at index: Int) -> ShopingItem
    
    func save(item: String)
    func update(indexPath: IndexPath, isMarked: Bool)
    func update(indexPath: IndexPath, newValue: String)
    func delete(indexPath: IndexPath)
}

// MARK: Shopping List View Model Impl
final class ShoppingListViewModelImpl: ShoppingListViewModel {
    // MARK: Properties
    private let itemsDidUpdateSubject: PassthroughSubject<Void, Never> = .init()
    var itemsDidUpdatePublisher: AnyPublisher<Void, Never> { itemsDidUpdateSubject.eraseToAnyPublisher() }
    
    private let noEntriesFountSubject: PassthroughSubject<String?, Never> = .init()
    var noEntriesFoundPublisher: AnyPublisher<String?, Never> { noEntriesFountSubject.eraseToAnyPublisher() }
    
    private let moveTableViewRowSubject: PassthroughSubject<(IndexPath, IndexPath), Never> = .init()
    var moveTableViewRowPublisher: AnyPublisher<(IndexPath, IndexPath), Never> { moveTableViewRowSubject.eraseToAnyPublisher() }
    
    private var _shoppingItems: [ShopingItem] = []
    private var shoppingItems: [ShopingItem] {
        get {
            _shoppingItems.sorted(by: { !$0.isMarked && $1.isMarked })
        }
        set {
            _shoppingItems = newValue
        }
    }
    // MARK: Life Cycle
    func viewDidLoad() {
        fetchShoppingItems()
    }
    
    // MARK: Table View
    func numberOfRowsInSection() -> Int {
        shoppingItems.count
    }
    
    func item(at index: Int) -> ShopingItem {
        shoppingItems[index]
    }
    
    // MARK: Request
    func save(item: String) {
        ShoppingRepository.shared.saveShoppingItem(
            item: .init(title: item, isMarked: false),
            success: { [weak self] in
                self?.fetchShoppingItems()
            })
    }
    
    func update(indexPath: IndexPath, isMarked: Bool) {
        let oldValue = item(at: indexPath.row)
        let newValue = ShopingItem(title: oldValue.title, isMarked: !isMarked)
        
        ShoppingRepository.shared.updateItem(oldItem: oldValue,
                                             newItem: newValue,
                                             success: { [weak self] in
            guard let self else { return }
            shoppingItems = ShoppingRepository.shared.fetchItems()
            sendMoveTableViewRowSubjectIfNeeded(from: indexPath, newItem: newValue)
        })
    }
    
    private func sendMoveTableViewRowSubjectIfNeeded(from fromIndex: IndexPath, newItem: ShopingItem) {
        var toIndex: IndexPath? {
            if newItem.isMarked {
                if let nonMarkedLastIndex = shoppingItems.lastIndex(where: { !$0.isMarked }) {
                    return IndexPath(row: nonMarkedLastIndex + 1, section: .zero)
                }
            } else {
                if let markedLastIndex = shoppingItems.firstIndex(where: { $0.isMarked }) {
                    return IndexPath(row: markedLastIndex - 1, section: .zero)
                }
            }
            return nil
        }
        
        if let toIndex {
            moveTableViewRowSubject.send((fromIndex, toIndex))
        }
    }
    
    func update(indexPath: IndexPath, newValue: String) {
        let oldValue = item(at: indexPath.row)
        let newValue = ShopingItem(title: newValue, isMarked: oldValue.isMarked)
        
        if oldValue.title != newValue.title {
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
        
        shoppingItems.isEmpty ? noEntriesFountSubject.send("There is no items") : noEntriesFountSubject.send(nil)
    }
}

//
//  ShoppingListViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 24.03.24.
//

import UIKit

protocol ShoppingListViewModel {
    func numberOfRowsInSection() -> Int
    func item(at index: Int) -> String

}

final class ShoppingListViewModelImpl: ShoppingListViewModel {
    
    // MARK: - Properties
    private var shoppingItems: [String] = ["", "", "", "", ""]
    
    func numberOfRowsInSection() -> Int {
        shoppingItems.count
    }
    
    func item(at index: Int) -> String {
        shoppingItems[index]
    }


}

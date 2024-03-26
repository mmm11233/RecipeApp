//
//  ShopingItem.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 26.03.24.
//

import Foundation

// MARK: Shoping Model
struct ShopingItem {
    var id: String = UUID().uuidString
    let title: String
    let isMarked: Bool
}

extension ShoppingList {
    func toShopingItem() -> ShopingItem {
        ShopingItem(id: id ?? UUID().uuidString,
                     title: shoppingItem ?? "",
                     isMarked: isMarked)
    }
}

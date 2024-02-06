//
//  NotificationCenter+Extensions.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 05.02.24.
//

import Foundation

extension Notification.Name {
    static let updateFavourites = Notification.Name("update_favourites")
}

extension NotificationCenter {
    func postUpdateFavourites() {
        post(name: .updateFavourites, object: nil)
    }
}

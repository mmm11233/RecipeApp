//
//  FavouritesViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 02.02.24.
//

import Foundation
import CoreData

final class FavouritesViewModel {
//    @Published var favoriteDishes: [DishCoreData] = []
    
    // Add managed object context
    var managedObjectContext: NSManagedObjectContext?

    init(managedObjectContext: NSManagedObjectContext?) {
        self.managedObjectContext = managedObjectContext
    }
    // ... other methods ...

    // Fetch favorite dishes
    func fetchFavoriteDishes() {
        // Implement fetching favorite dishes from Core Data using managedObjectContext
        // Set the result to `favoriteDishes`
    }
}

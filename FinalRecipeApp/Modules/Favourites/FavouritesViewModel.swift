//
//  FavouritesViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 02.02.24.
//

import Foundation
import CoreData
import Combine

protocol FavouritesViewModel {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
}

final class FavouritesViewModelImpl: FavouritesViewModel {
//    @Published var favoriteDishes: [DishCoreData] = []
    
    var isLoading: CurrentValueSubject<Bool, Never> = .init(false)

    // Add managed object context
    var managedObjectContext: NSManagedObjectContext?

    init(managedObjectContext: NSManagedObjectContext?) {
        self.managedObjectContext = managedObjectContext
    }
    
    // ... other methods ...

    // Fetch favorite dishes
    func fetchFavoriteDishes() {
        
    }
}

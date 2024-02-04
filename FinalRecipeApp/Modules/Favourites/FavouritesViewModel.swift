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
    func viewDidLoad()
}

final class FavouritesViewModelImpl: FavouritesViewModel {
//    @Published var favoriteDishes: [DishCoreData] = []
    
    // Add managed object context
    var managedObjectContext: NSManagedObjectContext?

    init(managedObjectContext: NSManagedObjectContext?) {
        self.managedObjectContext = managedObjectContext
    }
    
    func viewDidLoad() {
        fetchFavoriteDishes()
    }
    
    // Fetch favorite dishes
    func fetchFavoriteDishes() {
        
    }
}

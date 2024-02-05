//
//  FavouritesViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 02.02.24.
//
import Foundation
import UIKit
import CoreData
import Combine

protocol FavouritesViewModel {
    func viewDidLoad()
    func updateDataSource()
    
    func numberOfItemsInSection() -> Int
    func didSelectRowAt(at index: Int, from viewController: UIViewController)
    func item(at index: Int) -> Dish
}

final class FavouritesViewModelImpl: FavouritesViewModel {
    @Published var favoriteDishes: [Recipe] = []
    
    var managedObjectContext: NSManagedObjectContext?
    
    init(managedObjectContext: NSManagedObjectContext?) {
        self.managedObjectContext = managedObjectContext
    }
    
    func viewDidLoad() {
        fetchFavoriteDishes()
    }
    
    func updateDataSource() {
        fetchFavoriteDishes()
    }
    
    func numberOfItemsInSection() -> Int {
        return favoriteDishes.count
    }
    
    func item(at index: Int) -> Dish {
        let recipe = favoriteDishes[index]
        return recipe.toDishModel()
    }
    
    func didSelectRowAt(at index: Int, from viewController: UIViewController) {
        let recipe = favoriteDishes[index]
        let dish = recipe.toDishModel()
       
        let vc  = DetailsViewController()
        vc.viewModel = DetailsViewModel(selectedDish: dish)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Fetch favorite dishes
    func fetchFavoriteDishes() {
        guard let context = managedObjectContext else {
            print("Error: Managed object context is nil.")
            return
        }
        
        do {
            // Fetching favorite dishes from Core Data
            let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
            self.favoriteDishes = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching favorite dishes: \(error.localizedDescription)")
        }
    }
}

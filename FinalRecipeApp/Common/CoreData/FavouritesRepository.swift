//
//  FavouritesRepository.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 05.02.24.
//

import UIKit
import CoreData

final class FavouritesRepository  {
  
    static let shared = FavouritesRepository()
    
    private let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.container = appDelegate.persistentContainer
    }
    
    //MARK: - Methods
    func saveDish(dish: Dish) {
        let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: context)
        let newRecipe = NSManagedObject(entity: entity!, insertInto: context)
        
        newRecipe.setValue(NSNumber(value: dish.calories), forKey: "calorie")
        newRecipe.setValue(dish.name, forKey: "name")
        newRecipe.setValue(NSNumber(value: dish.preparingTime), forKey: "preparingTime")
        newRecipe.setValue(dish.pictureURL, forKey: "pictureURL")
        print("storing data...")
        do {
            try context.save()
            NotificationCenter.default.postUpdateFavourites()
        } catch {
            print("Storing Data Faild")
        }
    }
    
    func deleteDish(dish: Dish) {
           let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "name == %@", dish.name) 
           
           do {
               let matchingDishes = try context.fetch(fetchRequest)
               
               if let dishToDelete = matchingDishes.first {
                   context.delete(dishToDelete)
                   
                   do {
                       try context.save()
                       NotificationCenter.default.postUpdateFavourites()
                   } catch {
                       print("Deleting Dish Failed: \(error.localizedDescription)")
                   }
               }
           } catch {
               print("Error fetching dishes to delete: \(error.localizedDescription)")
           }
       }
    
    func fetchDishes() -> [Dish] {
        do {
            let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
            let dishes = try context.fetch(fetchRequest)
            return dishes.map({ $0.toDishModel() })
        } catch {
            print("Error fetching favorite dishes: \(error.localizedDescription)")
        }
        return []
    }
    
    func isDishFavorite(dish: Dish) -> Bool {
           let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "name == %@", dish.name)
           
           do {
               let matchingDishesCount = try context.count(for: fetchRequest)
               return matchingDishesCount > 0
           } catch {
               print("Error checking if dish is favorite: \(error.localizedDescription)")
               return false
           }
       }
}

//
//  ShoppingRepository.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 25.03.24.
//

import UIKit
import CoreData

final class ShoppingRepository  {
    
    // MARK: - Properties
    static let shared = ShoppingRepository()
    
    private let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    // MARK: - Init
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.container = appDelegate.persistentContainer
    }
    
    //MARK: - Methods
    func saveShoppingItem(item: String, success: () -> ()) {
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingList", in: context)
        let newItem = NSManagedObject(entity: entity!, insertInto: context)
        newItem.setValue(item, forKey: "shoppingItem")
        
        do {
            try context.save()
            success()
        } catch {
            print("Storing Data Faild")
        }
    }
    
    func deleteItem(item: String, success: () -> ()) {
        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "shoppingItem == %@", item)
        
        do {
            let matchingItems = try context.fetch(fetchRequest)
            
            if let itemToDelete = matchingItems.first {
                context.delete(itemToDelete)
                
                do {
                    try context.save()
                    success()
                } catch {
                    print("Deleting items Failed: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Error fetching items to delete: \(error.localizedDescription)")
        }
    }
    
    func fetchItems() -> [String] {
        do {
            let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
            let items = try context.fetch(fetchRequest)
            return items.map({ $0.shoppingItem! })
        } catch {
            print("Error fetching favorite dishes: \(error.localizedDescription)")
        }
        return []
    }
}

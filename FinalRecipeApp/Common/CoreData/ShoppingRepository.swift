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
    func saveShoppingItem(item: ShopingItem, success: () -> ()) {
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingList", in: context)
        let newItem = NSManagedObject(entity: entity!, insertInto: context)
        newItem.setValue(item.id, forKey: "id")
        newItem.setValue(item.title, forKey: "shoppingItem")
        newItem.setValue(item.isMarked, forKey: "isMarked")

        do {
            try context.save()
            success()
        } catch {
            print("Storing Data Faild")
        }
    }
    
    func deleteItem(item: ShopingItem, success: () -> ()) {
        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id)
        
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
    
    func fetchItems() -> [ShopingItem] {
        do {
            let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
            let items = try context.fetch(fetchRequest)
            return items.map({ $0.toShopingItem() })
        } catch {
            print("Error fetching favorite dishes: \(error.localizedDescription)")
        }
        return []
    }
    
    func updateItem(oldItem: ShopingItem, newItem: ShopingItem, success: () -> ()) {
        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", oldItem.id)
        
        do {
            let matchingItems = try context.fetch(fetchRequest)
            
            if let itemToUpdate = matchingItems.first {
                itemToUpdate.setValue(newItem.title, forKey: "shoppingItem")
                itemToUpdate.setValue(newItem.isMarked, forKey: "isMarked")

                do {
                    try context.save()
                    success()
                } catch {
                    print("Updating item failed: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Error fetching item to update: \(error.localizedDescription)")
        }
    }

}

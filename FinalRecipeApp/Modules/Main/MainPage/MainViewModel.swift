//
//  MainViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import UIKit
import NetSwift
import CoreData
import Combine

final class MainViewModel: ObservableObject {
    //MARK: - Properties
    private var subscribers = Set<AnyCancellable>()
    
    private var dishesService: DishesService
    @Published var dishes: [Dish] = []
    @Published var searchText: String = ""
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    var filteredDishes: [Dish] {
        guard !searchText.isEmpty else { return dishes }
        return dishes.filter { dish in
            dish.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var favouriteButtonTapPublisher: PassthroughSubject<Dish, Never> = .init()
    
    //MARK: - Init
    init(dishesService: DishesService) {
        self.dishesService = dishesService
        setupBindigs()
        fetchDishes()
    }
    
    private func setupBindigs() {
        favouriteButtonTapPublisher
            .sink { [weak self] dish in
                self!.openDatabse()
                print("favourite button taapped: ", dish.name)
            }.store(in: &subscribers)
    }
    
    
    
    //MARK: - Methods
    func openDatabse()
    {
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: context)
        let newRecipe = NSManagedObject(entity: entity!, insertInto: context)
        saveData(RecipeDBObj:newRecipe)
    }
    
    func saveData(RecipeDBObj:NSManagedObject)
    {
        RecipeDBObj.setValue(NSNumber(value: 12), forKey: "calorie")
        RecipeDBObj.setValue("dishname1", forKey: "name")
        RecipeDBObj.setValue(NSNumber(value: 1), forKey: "preparingTime")
        RecipeDBObj.setValue("pictureURL1", forKey: "pictureURL")
        
        print("Storing Data..")
        do {
            try context.save()
        } catch {
            print("Storing data Failed")
        }
        
        fetchData()
    }
    
    func fetchData() {
        print("Fetching Data..")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let name = data.value(forKey: "name") as? String,
                      let pictureURL = data.value(forKey: "pictureURL") as? String,
                      let calorie = data.value(forKey: "calorie") as? Int,
                      let preparingTime = data.value(forKey: "preparingTime") as? Int else {
                    print("Error: Unable to fetch data")
                    continue
                }
                
                print("Recipe Name is : \(name) and pictureURL is : \(pictureURL)")
                print("Calorie: \(calorie), Preparing Time: \(preparingTime)")
            }
        } catch {
            print("Fetching data Failed")
        }
    }
    
    func fetchDishes() {
        dishesService.fetchDishes(completion: { [weak self] result in
            switch result {
            case .success(let dishes):
                self?.dishes = dishes
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

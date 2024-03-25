//
//  RecipeTabBarController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 24.03.24.
//

import UIKit
import SwiftUI

final class RecipeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
    }
    
    // MARK: Configure Tab Bar
    private func configureTabBarController() {
        // MARK: Main View
        let mainView = MainView(viewModel: MainViewModel(dishesService: DishesServiceImpl()))
        let mainVC = UIHostingController(rootView: mainView)
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: ImageBook.Icons.house, tag: 0)
        
        // MARK: Favourites View
        let favouritesVC = FavouritesViewController(viewModel:  FavouritesViewModelImpl())
        favouritesVC.tabBarItem = UITabBarItem(title: "Favourites", image: ImageBook.Icons.tabBarHeart, tag: 1)
        
        let favouritesNavigationController = UINavigationController(rootViewController: favouritesVC)
        
        // MARK: Categories View
        let categoriesVM = CategoriesViewModelImpl(categoriesService: CategoriesServiceImpl())
        let categoriesVC = CategoriesViewController(viewModel: categoriesVM)
        let categoriesNavigationController = UINavigationController(rootViewController: categoriesVC)
        categoriesVC.tabBarItem = UITabBarItem(title: "Categories", image: ImageBook.Icons.bullet, tag: 2)
        
        // MARK: ShoppingList View
        let shoppingListVM = ShoppingListViewModelImpl()
        let shoppingListVC = ShoppingListViewController(viewModel: shoppingListVM)
        let shoppingListNavigationController = UINavigationController(rootViewController: shoppingListVC)
        shoppingListVC.tabBarItem = UITabBarItem(title: "Shopping List", image: ImageBook.Icons.pencil, tag: 3)
        
        // MARK: Tab Bar Configuration
        viewControllers = [mainVC,favouritesNavigationController, categoriesNavigationController,shoppingListVC]
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorBook.black as Any]
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = ColorBook.orange
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}

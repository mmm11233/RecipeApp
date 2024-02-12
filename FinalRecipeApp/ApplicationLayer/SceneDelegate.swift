//
//  SceneDelegate.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 17.01.24.
//

import UIKit
import SwiftUI
import GoogleMaps

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        GMSServices.provideAPIKey("AIzaSyC1ghcYulVlTBi3T-hF7JdTWQDVyJPKZy8")
    }
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
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
        
        // MARK: Tab Bar Configuration
        tabBarController.viewControllers = [mainVC,favouritesNavigationController, categoriesNavigationController]
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorBook.black as Any]
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = ColorBook.orange
        
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        
        return tabBarController
    }
}

//
//  SceneDelegate.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 17.01.24.
//

import UIKit
import SwiftUI
import GoogleMaps
import Combine

// MARK: Scene Delegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: Properties
    var window: UIWindow?
    
    private var subscribers = Set<AnyCancellable>()
    
    // MARK: UI Window Scene Delegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = createRootViewController()
        
        if let apiKey = ProcessInfo.processInfo.environment["GOOGLE_MAP_API_KEY"] {
            GMSServices.provideAPIKey(apiKey)
        }
        addInternetConnectionObserver()
        
        window?.makeKeyAndVisible()
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        NetworkReachabilityService.shared.startObserving()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        NetworkReachabilityService.shared.stopObserving()
    }
    
    // MARK: Configuration
    private func createRootViewController() -> UIViewController {
        if UserDefaults.isOnboardingAlreadyCompleted {
            RecipeTabBarController()
        } else {
            OnboardingViewController(viewModel: OnboardingViewModelImpl())
        }
    }
    
    // MARK: Internet Connection
    private func addInternetConnectionObserver() {
        NotificationCenter.default.publisher(for: .noInternetConnection)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                let alert = UIAlertController(title: "No Internet Connection", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }.store(in: &subscribers)
    }
}

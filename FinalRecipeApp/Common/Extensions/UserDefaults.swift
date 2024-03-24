//
//  UserDefaults.swift
//  FinalRecipeApp
//
//  Created by Rezo Joglidze on 24.03.24.
//

import Foundation

extension UserDefaults {
    
    struct Keys {
        static let isOnboardingAlreadyCompleted = "isOnboardingAlreadyCompleted"
    }
    
    static var isOnboardingAlreadyCompleted: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.isOnboardingAlreadyCompleted)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isOnboardingAlreadyCompleted);
            UserDefaults.standard.synchronize()
        }
    }
}
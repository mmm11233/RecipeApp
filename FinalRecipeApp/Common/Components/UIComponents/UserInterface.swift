//
//  UserInterface.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 08.02.24.
//

import UIKit

import UIKit

struct AppearanceManager {
    static func updateAppearanceForInterfaceStyle(_ style: UIUserInterfaceStyle, in view: UIView) {
        switch style {
        case .unspecified, .light:
            // Apply light mode appearance
            view.backgroundColor = UIColor.white
            // Other appearance adjustments...
        case .dark:
            // Apply dark mode appearance
            view.backgroundColor = UIColor.black
            // Other appearance adjustments...
        @unknown default:
            break
        }
    }
}


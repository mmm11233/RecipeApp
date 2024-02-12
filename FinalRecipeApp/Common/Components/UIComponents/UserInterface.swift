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
            
            view.backgroundColor = UIColor.white
            
        case .dark:
            
            view.backgroundColor = UIColor.black
            
        @unknown default:
            break
        }
    }
}

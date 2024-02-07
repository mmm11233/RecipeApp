//
//  NavigationBarTitle.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 07.02.24.
//

import UIKit

extension UIViewController {
    func configureNavigationBarTitle(title: String, font: UIFont, textColor: UIColor) {
        let attributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: textColor
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.title = title
    }
}

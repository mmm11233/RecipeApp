//
//  ShadowView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.01.24.
//

import UIKit

// MARK: UIView + apply Shadow
extension UIView {
    func applyShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}

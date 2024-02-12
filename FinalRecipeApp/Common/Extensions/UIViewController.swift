//
//  UIViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//

import UIKit

extension UIViewController {
    
    // MARK: - Methods
    private var activityIndicatorTag: Int {
        return 99999999
    }
    
    func startLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = self.view.center
            activityIndicator.tag = self.activityIndicatorTag
            activityIndicator.startAnimating()
            
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let activityIndicator = self.view.viewWithTag(self.activityIndicatorTag) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}

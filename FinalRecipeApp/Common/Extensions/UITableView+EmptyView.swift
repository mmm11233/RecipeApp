//
//  UITableView+EmptyView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 26.03.24.
//

import UIKit

extension UITableView {
    func setEmptyView(title: String) {
        var titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor.black
            label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
            label.text = title
            
            return label
        }()
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.addSubview(titleLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restoreEmptyView() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

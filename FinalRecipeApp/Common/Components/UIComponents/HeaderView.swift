//
//  HeaderView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 21.01.24.
//

import UIKit

final class HeaderView: UIView {
    let titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Header"
        label.font = .boldSystemFont(ofSize: 25) 
        label.textColor = UIColor.black

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor.lightGray
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
    }
}

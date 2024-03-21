//
//  OnboardingCollectionViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 20.03.24.
//

import UIKit
import SwiftUI

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = ColorBook.black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(with model: OnboardingCollectionViewModel) {
        titleLabel.text = model.title
        imageView.image = model.image
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -200),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 80),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            titleLabel.heightAnchor.constraint(equalToConstant: 56)
            
        ])
    }
}

#Preview {
    OnboardingCollectionViewCell()
}

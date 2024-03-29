//
//  OnboardingCollectionViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 20.03.24.
//

import UIKit
import SwiftUI

// MARK: Onboarding Collection View Cell
final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = ColorBook.black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: Configuration
    func configure(with model: OnboardingCollectionViewModel) {
        titleLabel.text = model.title
        imageView.image = model.image
    }
    
    // MARK: Setup
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        titleLabel.setContentCompressionResistancePriority(.init(1000), for: .vertical)
    }
}

//
//  OnboardingCollectionViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 20.03.24.
//

import UIKit

class OnboardingCollectionViewCell: UIViewController {
    
    // MARK: - Properties
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageBook.Images.onBoardingFirst
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let onboardingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = ColorBook.pink.withAlphaComponent(1.0)
        button.layer.cornerRadius = 12
        button.setTitleColor(ColorBook.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - Configure
    private func addSubviews() {
        view.addSubview(imageView)
        imageView.addSubview(onboardingButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            onboardingButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 40),
            onboardingButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -40),
            onboardingButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            onboardingButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -100),
            onboardingButton.heightAnchor.constraint(equalToConstant: 56)
            
        ])
    }
}

#Preview {
    OnboardingCollectionViewCell()
}

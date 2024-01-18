//
//  OnBoardingPage.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 18.01.24.
//

import UIKit
import SwiftUI

final class OnBoardingPage: UIViewController {
    
    //MARK: properties
    private let mainImage: UIImageView = {
        return createImageView(with: "image 8")
    }()
    
    private let middleImage: UIImageView = {
        return createImageView(with: "Ellipse 10")
    }()
    
    private let ellipseImage: UIImageView = {
        return createImageView(with: "Ellipse 8")
    }()
    
    private let appTitle: UILabel = {
        let label = UILabel()
        label.text = "Savory & Sweet"
        label.textColor = .white
        label.numberOfLines = 2
        label.font = label.font.withSize(36)
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2.0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: methods
    private func setupUI() {
        [mainImage, ellipseImage, middleImage].forEach {
            $0.contentMode = .scaleAspectFill
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        view.addSubview(appTitle)
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            ellipseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ellipseImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ellipseImage.widthAnchor.constraint(equalToConstant: 225),
            ellipseImage.heightAnchor.constraint(equalToConstant: 225),
            
            middleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            middleImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            middleImage.widthAnchor.constraint(equalToConstant: 210),
            middleImage.heightAnchor.constraint(equalToConstant: 210),
            
            appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appTitle.bottomAnchor.constraint(equalTo: ellipseImage.topAnchor, constant: -45)
        ])
    }
}

#Preview {
    let vc = OnBoardingPage()
    return vc
}

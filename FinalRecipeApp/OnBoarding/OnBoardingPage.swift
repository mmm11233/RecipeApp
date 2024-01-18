//
//  OnBoardingPage.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 18.01.24.
//

import UIKit
import SwiftUI

class OnBoardingPage: UIViewController {
    //MARK: properties
    let mainImage: UIImageView = {
        return createImageView(with: "image 8")
    }()
    
    let middleImage: UIImageView = {
        return createImageView(with: "Ellipse 10")
    }()
    
    let ellipseImage: UIImageView = {
        return createImageView(with: "Ellipse 8")
    }()
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: methods
    private func setupUI() {
        mainImage.contentMode = .scaleAspectFill
        view.addSubview(mainImage)
        
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        ellipseImage.contentMode = .scaleAspectFill
        view.addSubview(ellipseImage)
        ellipseImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ellipseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ellipseImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ellipseImage.widthAnchor.constraint(equalToConstant: 225),
            ellipseImage.heightAnchor.constraint(equalToConstant: 225)
        ])
        
        middleImage.contentMode = .scaleAspectFill
        view.addSubview(middleImage)
        middleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            middleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            middleImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            middleImage.widthAnchor.constraint(equalToConstant: 210),
            middleImage.heightAnchor.constraint(equalToConstant: 210)
        ])
        
    }
}

#Preview {
    let vc = OnBoardingPage()
    
    return vc
}



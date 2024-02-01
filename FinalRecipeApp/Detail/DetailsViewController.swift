//
//  DetailsViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 28.01.24.
//

import UIKit
import SwiftUI

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var image: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image = UIImageView(image: UIImage(named: "imag1"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-CondensedBold", size: 39)
        label.textColor = .black
        label.text = "pizza"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = .black
        label.text = "350Kcal"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let prepareTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        label.textColor = .black
        label.text = "45min"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geeza Pro Regular", size: 16)
        label.textColor = .black
        label.text = "tomato, potato, pasta"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupContraints()
        //        configureViews()
    }
    
    // MARK: - Configure
    //    private func configureViews() {
    //        guard let recipe = recipe else {
    //            print("Recipe is nil")
    //            return
    //        }
    //        image.image = recipe.image
    //        nameLabel.text = recipe.name
    //        caloriesLabel.text = recipe.caloreis
    //        prepareTimeLabel.text = recipe.prepareTime
    //        ingredientsLabel.text = recipe.ingredients
    //    }
    
    private func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(caloriesLabel)
        stackView.addArrangedSubview(prepareTimeLabel)
        stackView.addArrangedSubview(ingredientsLabel)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            image.heightAnchor.constraint(equalToConstant: 300),
            image.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0),
        ])
        
    }
}

#Preview {
    let vc = DetailsViewController()
    return vc
}

//
//  FavouriteCollectionViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 01.02.24.
//
import SwiftUI
import UIKit
import Combine

// MARK: Dish Collection View Cell
final class DishCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private var hostingController: UIHostingController<DishComponentView>?
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHostingController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupHostingController() {
        let dishesComponentView = DishComponentView(model: .init(dish: .mock, favouriteButtonIsHidden: false))
        let hostingController = UIHostingController(rootView: dishesComponentView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        self.hostingController = hostingController
    }
    
    // MARK: Configuration
    func configure(model: DishComponentModel) {
        hostingController?.rootView.model = model
    }
}

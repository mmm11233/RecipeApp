//
//  FavouriteCollectionViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 01.02.24.
//
import SwiftUI
import UIKit
import Combine

class DishCollectionViewCell: UICollectionViewCell {
    
    private var hostingController: UIHostingController<DishesComponentView>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHostingController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHostingController() {
        let dishesComponentView = DishesComponentView(dish: .mock,
                                                      favouriteButtonIsHidden: false)
        let hostingController = UIHostingController(rootView: dishesComponentView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hostingController.view)
        
        switch traitCollection.userInterfaceStyle {
        case .unspecified, .light:
            
            hostingController.view.backgroundColor = UIColor.white
            
        case .dark:
            
            hostingController.view.backgroundColor = UIColor.black
            
        @unknown default:
            break
        }
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
        self.hostingController = hostingController
    }
    
    func configure(dish: Dish,
                   favouriteButtonIsHidden: Bool,
                   favouriteButtonTapPublisher: PassthroughSubject<Dish, Never>
    ) {
        hostingController?.rootView.dish = dish
        hostingController?.rootView.favouriteButtonIsHidden = favouriteButtonIsHidden
        hostingController?.rootView.favouriteButtonTapPublisher = favouriteButtonTapPublisher
    }
}

#Preview {
    let vc = DishCollectionViewCell()
    return vc
}

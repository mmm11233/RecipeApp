//
//  FavouriteCollectionViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 01.02.24.
//
import SwiftUI
import UIKit

class FavouritesCollectionViewCell: UICollectionViewCell {
    
    private var hostingController: UIHostingController<DishesComponentView>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHostingController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHostingController() {
        let dishesComponentView = DishesComponentView(imageUrl: "your_image_url",
                                                      name: "Dish Name",
                                                      calorie: 300,
                                                      prepareTime: 30)
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
    
    func configure(imageUrl: String, name: String, calorie: Int, prepareTime: Int) {
        hostingController?.rootView.imageUrl = imageUrl
        hostingController?.rootView.name = name
        hostingController?.rootView.calorie = calorie
        hostingController?.rootView.prepareTime = prepareTime
    }
}

#Preview {
    let vc = FavouritesCollectionViewCell()
    return vc
}

//
//  OnBoardingImageComponent.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.01.24.
//

import UIKit

 func createImageView(with imageName: String) -> UIImageView {
       let image = UIImage(named: imageName)
       let imageView = UIImageView(image: image)
       return imageView
   }

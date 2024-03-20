//
//  OnboardingViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 20.03.24.
//

import UIKit

protocol OnboardingViewModel {
    var items: [OnboardingCollectionViewModel] { get }
}

class OnboardingViewModelImpl: UIViewController {
    var items: [OnboardingCollectionViewModel] = []
    
    func setup() {
        updateDataSource()
    }
    
    func updateDataSource() {
        items = [
            .init(title: "onBoarding Page", image: ImageBook.Images.onBoardingFirst)
        ]
    }

}

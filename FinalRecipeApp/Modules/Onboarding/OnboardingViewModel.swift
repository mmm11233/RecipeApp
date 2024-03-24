//
//  OnboardingViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 20.03.24.
//

import UIKit

protocol OnboardingViewModel {
    var currentPage: Int { get set }
    var items: [OnboardingCollectionViewModel] { get }
    var backgroundColor: UIColor { get }

    func setup()
    func mainButtonTapped(from viewController: UIViewController)
}

final class OnboardingViewModelImpl: OnboardingViewModel {
    var currentPage: Int = 0
    var items: [OnboardingCollectionViewModel] = []
    
    var backgroundColor: UIColor {
        Constants.colorsDataSource[currentPage]
    }
    
    func setup() {
        updateDataSource()
    }
    
    private func updateDataSource() {
        items = [
            .init(title: "მოიძიე სასურველი კერძი", image: ImageBook.Images.onBoardingFirst),
            .init(title: "შეინახე სასურველი კერძი", image: ImageBook.Images.onBoardingSecond),
            .init(title: "იპოვე კერძი კატეგორიების მიხედვით", image: ImageBook.Images.onBoardingThird),
            .init(title: "გადადი კერძის დეტალურ გვერძე", image: ImageBook.Images.onBoardingFourth),
            .init(title: "იპოვე საუკეთესო ადგილი,სადაც შეძლებ კერძის დაგემოვნებას", image: ImageBook.Images.onBoardingFifth),
            .init(title: "დასერჩე კერძი ინგრედიენტების მიხედვით", image: ImageBook.Images.onBoardingSixth),
        ]
    }
    func mainButtonTapped(from viewController: UIViewController) {
        UserDefaults.isOnboardingAlreadyCompleted = true
        
        let tabBarController = RecipeTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        
        viewController.present(tabBarController, animated: false)
    }
}

private extension OnboardingViewModelImpl {
    enum Constants {
        static let colorsDataSource: [UIColor] = [
            ColorBook.lightGray,
            ColorBook.lightYellow,
            ColorBook.lightGreen,
            ColorBook.lightOrange,
            ColorBook.lightYellow,
            ColorBook.lightGray,
        ]
    }
}

//
//  OnboardingViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 20.03.24.
//

import UIKit

// MARK: - Onboarding View Model
protocol OnboardingViewModel {
    var items: [OnboardingCollectionViewModel] { get }

    func viewDidLoad()
    func backgroundColor(at index: Int) -> UIColor
    func mainButtonTapped(from viewController: UIViewController)
}

// MARK: - Onboarding View Model Impl
final class OnboardingViewModelImpl: OnboardingViewModel {
    // MARK: Properties
    var items: [OnboardingCollectionViewModel] = []
    
    // MARK: Lifecycle
    func viewDidLoad() {
        updateDataSource()
    }
    
    // MARK: Methods
    func backgroundColor(at index: Int) -> UIColor {
        Constants.colorsDataSource[index]
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
    
    // MARK: User Interaction
    func mainButtonTapped(from viewController: UIViewController) {
        UserDefaults.isOnboardingAlreadyCompleted = true
        
        let tabBarController = RecipeTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        
        viewController.present(tabBarController, animated: false)
    }
}

// MARK: - Private Constants
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

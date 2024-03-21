//
//  OnboardingViewModel.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 20.03.24.
//

import UIKit

protocol OnboardingViewModel {
    var currentPage: Int {get set}
    var items: [OnboardingCollectionViewModel] { get }
    func setup()
}

final class OnboardingViewModelImpl: OnboardingViewModel {
    var currentPage: Int = 0
    var items: [OnboardingCollectionViewModel] = []
    
    func setup() {
        updateDataSource()
    }
    
    private func updateDataSource() {
        items = [
            .init(title: "მოიძიე სასურველი კერძი", image: ImageBook.Images.pageControlFirst),
            .init(title: "შეინახე საუკეთესო კერძი", image: ImageBook.Images.pageControlSecond),
            .init(title: "ჩაინიშნე ინგრედიენტები", image: ImageBook.Images.pageControlThird)
        ]
    }

}

//
//  ImageBook.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 12.02.24.
//

import UIKit

struct ImageBook {
    private init() { }
    
    struct Images {
        static var defaultPhoto: UIImage = .init(systemName: "photo")!
        static var ellipseCollor: UIImage = .init(named: "EllipseColor")!
        static var ellipseDish: UIImage = .init(named: "EllipseDish")!
        static var onboardingImage: UIImage = .init(named: "OnboardingImage")!
        static var onBoardingFirst: UIImage = .init(named: "Onboarding1")!
        static var onBoardingSecond: UIImage = .init(named: "Onboarding2")!
        static var onBoardingThird: UIImage = .init(named: "Onboarding3")!
        static var onBoardingFourth: UIImage = .init(named: "Onboarding4")!
        static var onBoardingFifth: UIImage = .init(named: "Onboarding5")!
        static var onBoardingSixth: UIImage = .init(named: "Onboarding6")!

        
    }
    
    struct Icons {
        static var breakfast: UIImage = .init(named: "Breakfast")!
        static var bullet: UIImage = .init(systemName: "list.bullet")!
        static var clock: UIImage = .init(named: "Clock")!
        static var desserts: UIImage = .init(named: "Desserts")!
        static var drinks: UIImage = .init(named: "Drinks")!
        static var fire: UIImage = .init(named: "Fire")!
        static var heart: UIImage = .init(named: "Heart")!
        static var heartFill: UIImage = .init(named: "HeartFill")!
        static var house: UIImage = .init(systemName: "house")!
        static var lunch: UIImage = .init(named: "Lunch")!
        static var pastas: UIImage = .init(named: "Pastas")!
        static var salads: UIImage = .init(named: "Salads")!
        static var searchIcon: UIImage = .init(systemName: "magnifyingglass")!
        static var soups: UIImage = .init(named: "Soups")!
        static var tabBarHeart: UIImage = .init(systemName: "heart.fill")!
        static var xMark: UIImage = .init(systemName: "xmark.circle.fill")!
    }
}

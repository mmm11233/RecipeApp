//
//  MainView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: MainViewModel = .init()
    @State var path = NavigationPath()
    
    private let gridLayout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
    var body: some View {
        NavigationStack{
            Text("What is in your kitchen?")
                .font(.custom("AmericanTypewriter-CondensedBold", size: 30))
                .foregroundColor(.black)
                .padding(.top, 10)
            ScrollView {
                LazyVGrid(columns: gridLayout, spacing: 16) {
                    ForEach(viewModel.dishes) { dish in
                        DishesComponentView(imageUrl: dish.pictureURL,
                                            name: dish.name,
                                            calorie: dish.calories,
                                            prepareTime: dish.preparingTime)
                        .padding(5)
                    }
                }
                .padding()
            }
            .onAppear {
                viewModel.fetchDishes()
            }
        }
        
    }
}


#Preview {
    MainView()
}

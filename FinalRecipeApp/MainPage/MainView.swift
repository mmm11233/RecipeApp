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
    
    var items: [GridItem] {
      Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    // MARK: - Body
    var body: some View {
        Spacer()
        NavigationStack{
            
            TitleView(title: "Find Your Next Recipe")
            
            SearchBarComponentView(searchText: $viewModel.searchText)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: items, spacing: 10) {
                    ForEach(viewModel.filteredDishes) { dish in
                        DishesComponentView(imageUrl: dish.pictureURL,
                                            name: dish.name,
                                            calorie: dish.calories,
                                            prepareTime: dish.preparingTime)
                        .padding(5)
                    }
                }
                .padding(.horizontal)
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

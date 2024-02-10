//
//  MainView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: MainViewModel
    @State var path = NavigationPath()
    @Environment(\.colorScheme) var colorScheme

    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            TitleView(title: "Find Your Next Recipe")
            
            ScrollView(.vertical, showsIndicators: false) {
                SearchBarComponentView(searchText: $viewModel.searchText)
                
                LazyVGrid(columns: items, spacing: 10) {
                    ForEach(viewModel.filteredDishes) { dish in
                        NavigationLink(destination: DetailsView(viewModel: DetailsViewModelImpl(selectedDish: dish))) {
                            DishesComponentView(
                                dish: dish,
                                favouriteButtonIsHidden: false,
                                favouriteButtonTapPublisher: viewModel.favouriteButtonTapPublisher)
                            .padding(5)
                        }
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    }
                }
                .padding(.horizontal)
            }
            
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchDishes()
            }
        }
        .background(colorScheme == .dark ? Color("Dark Any") : Color.white)

    }
}


#Preview {
    MainView(viewModel: MainViewModel(dishesService: DishesServiceImpl()))
}

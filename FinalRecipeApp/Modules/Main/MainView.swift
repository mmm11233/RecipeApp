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
    @State private var hasAppeared = false
    @Environment(\.colorScheme) var colorScheme
    
    private var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            TitleView(title: "Find Your Next Recipe")
            
            contentView
            .navigationBarHidden(true)
            .onAppear {
                if !hasAppeared {
                    viewModel.fetchDishes()
                    self.hasAppeared = true
                }
            }
        }
    }
    
    //MARK: - Body Content View
    private var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            SearchBarComponentView(searchText: $viewModel.searchText)
            
            LazyVGrid(columns: items, spacing: 10) {
                ForEach(viewModel.filteredDishes) { dish in
                    NavigationLink(destination: DetailsView(viewModel: DetailsViewModelImpl(selectedDish: dish, mapButtonIsHidden: false))) {
                        DishComponentView(model: .init(dish: dish,
                                                         favouriteButtonIsHidden: false,
                                                         favouriteButtonTapPublisher: viewModel.favouriteButtonTapPublisher))
                        .padding(5)
                    }
                    .foregroundStyle(Color(ColorBook.white))
                }
            }
            .padding(.horizontal)
        }
    }
}

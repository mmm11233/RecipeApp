//
//  SearchBarComponentView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 26.01.24.
//

import SwiftUI

struct SearchBarComponentView: View {
    
    // MARK: - Properties
    @Binding var searchText: String
    @State private var isSearching: Bool = false
    
    // MARK: - Body
    var body: some View {
        searchBarView
    }
    
    // MARK: - Views
    private var searchBarView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)
            
            TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                withAnimation {
                    isSearching = isEditing
                }
            })
            .foregroundColor(.primary)
            
            if isSearching {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}

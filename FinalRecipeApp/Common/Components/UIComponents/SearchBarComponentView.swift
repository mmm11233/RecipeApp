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
        .padding(.vertical, 10)
        .padding(.horizontal, 14)
        .background(Color(.init(hexString: "F1F1F1")))
        .clipShape(Capsule())
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

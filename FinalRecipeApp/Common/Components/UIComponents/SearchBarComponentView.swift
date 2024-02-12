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
        conentView
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(Color(ColorBook.lightGray))
            .clipShape(Capsule())
            .padding(.leading, 30)
            .padding(.trailing, 30)
    }
    
    // MARK: - Views
    private var conentView: some View {
        HStack {
            Image(uiImage: ImageBook.Icons.searchIcon)
                .foregroundColor(Color(ColorBook.gray))
                .padding(.leading, 8)
            searchBarView
        }
    }
    
    private var searchBarView: some View {
        HStack {
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
                    Image(uiImage: ImageBook.Icons.xMark)
                        .foregroundColor(Color(ColorBook.gray))
                        .padding(.trailing, 8)
                }
            }
        }
    }
}

//
//  TitleView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 26.01.24.
//

import SwiftUI

struct TitleView: View {
    
    // MARK: - Properties
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    // MARK: - Body
    var body: some View {
        titleView
    }
    
    // MARK: - views
    private var titleView: some View {
        Text(title)
            .fontWeight(.semibold)
            .font(.system(size: 25))
            .padding(.top, 25)
    }
}

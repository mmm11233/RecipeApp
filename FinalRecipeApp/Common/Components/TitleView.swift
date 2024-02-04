//
//  TitleView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 26.01.24.
//

import SwiftUI

struct TitleView: View {
    var title: String
    
    // MARK: - Body
    var body: some View {
        titleView
    }
    
    // MARK: - views
    private var titleView: some View {
        Text(title)
            .font(.custom("AmericanTypewriter-CondensedBold", size: 30))
            .foregroundColor(.black)
            .padding(.top, 25)
    }
}

#Preview {
    TitleView(title: "Find Your Next Recipe")
}

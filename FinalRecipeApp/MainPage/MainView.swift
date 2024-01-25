//
//  MainView.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 23.01.24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel = .init()
    @State var path = NavigationPath()
    
    // MARK: - Properties
    private let gridLayout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            Text("What is in your kitchen?")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 10)
            ScrollView {
                LazyVGrid(columns: gridLayout, spacing: 16) {
                    ForEach(0..<viewModel.dishes.count) { _ in
                        DishesComponentView()
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


struct MainViewRepresentable: UIViewControllerRepresentable {
    // Define the Context type
    typealias Context = UIViewControllerRepresentableContext<Self>

    func makeUIViewController(context: Context) -> UIViewController {
        let hostingController = UIHostingController(rootView: MainView())
        hostingController.title = "SwiftUI"
        return hostingController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the view controller if needed
    }
}





#Preview {
    MainView()
}

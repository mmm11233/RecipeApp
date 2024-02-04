//
//  DetailsViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 28.01.24.
//

import UIKit
import SwiftUI

class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModel?
    
    // MARK: - Properties
    private let activityIndicator: UIActivityIndicatorView = {
          let indicator = UIActivityIndicatorView(style: .large)
          indicator.hidesWhenStopped = true
          indicator.translatesAutoresizingMaskIntoConstraints = false
          return indicator
      }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var imageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-CondensedBold", size: 30)
        label.textColor = .black
        label.text = "pizza"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = .black
        label.text = "350Kcal"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let prepareTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        label.textColor = .black
        label.text = "45min"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geeza Pro Regular", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupContraints()
        configureViews()
    }
    
    // MARK: - Configure
    private func configureViews() {
        if let viewModel = viewModel, let imageURL = URL(string: viewModel.selectedDish.pictureURL) {
            startLoading()

            downloadImage(from: imageURL)
            nameLabel.text = viewModel.selectedDish.name
            caloriesLabel.text = "\(viewModel.selectedDish.calories) Kcal"
            prepareTimeLabel.text = "\(viewModel.selectedDish.preparingTime) min"
            ingredientsLabel.text = viewModel.selectedDish.ingredients.joined(separator: ", ")
        }
    }
    
    private func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(caloriesLabel)
        stackView.addArrangedSubview(prepareTimeLabel)
        stackView.addArrangedSubview(ingredientsLabel)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0),
        ])
        
    }
    
    private func startLoading() {
            view.addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
            ])
            activityIndicator.startAnimating()
        }
        
        private func stopLoading() {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    
    private func downloadImage(from url: URL) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        self.stopLoading()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                }
            }.resume()
        }
    }



struct DetailsView: View {
    var viewModel: DetailsViewModel
    
    var body: some View {
        UIKitDetailsViewControllerRepresentable(viewModel: viewModel)
            .edgesIgnoringSafeArea(.all)
    }
}

struct UIKitDetailsViewControllerRepresentable: UIViewControllerRepresentable {
    var viewModel: DetailsViewModel
    
    func makeUIViewController(context: Context) -> DetailsViewController {
        let detailsViewController = DetailsViewController()
        detailsViewController.viewModel = viewModel
        return detailsViewController
    }
    
    func updateUIViewController(_ uiViewController: DetailsViewController, context: Context) {
    }
}

#Preview {
    let vc = DetailsViewController()
    return vc
}

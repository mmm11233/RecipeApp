//
//  DetailsViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 28.01.24.
//
import UIKit
import SwiftUI

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: DetailsViewModel?
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let scrollViewContent: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        return uiView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var imageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = UIColor(named: "Black")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "Black")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Gray")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let mapButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show In Map", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(mapButtonTapped(_:)), for: .touchUpInside)
        button.backgroundColor = .orange.withAlphaComponent(0.9)
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupContraints()
        configureViews()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor(named: "White")
    }
    
    // MARK: - Configure
    private func configureViews() {
        if let viewModel = viewModel, let imageURL = URL(string: viewModel.selectedDish.pictureURL) {
            startLoading()
            
            downloadImage(from: imageURL)
            titleLabel.text = viewModel.getTitle()
            subTitleLabel.text = viewModel.getSubTitle()
            descriptionLabel.text = viewModel.getDescription()
        }
    }
    
    private func addSubviews() {
        view.backgroundColor = UIColor(named: "Black")
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContent)
        
        scrollViewContent.addSubview(imageView)
        scrollViewContent.addSubview(stackView)
        scrollViewContent.addSubview(mapButton)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollViewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            stackView.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 34),
            
            mapButton.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 16),
            mapButton.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -16),
            mapButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
            mapButton.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor),
            mapButton.heightAnchor.constraint(equalToConstant: 56)
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
    
    // MARK: - Actions
    @objc func mapButtonTapped(_ sender: UIButton) {
        viewModel?.mapButtonTapped(from: self)
    }
    
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            if let data = data,
               let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self?.imageView.image = image
                    self?.stopLoading()
                }
            } else {
                DispatchQueue.main.async {
                    self?.stopLoading()
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

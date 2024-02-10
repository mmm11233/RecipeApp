//
//  CategoriesdetailsViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//
import UIKit
import Combine

final class CategoriesDetailsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        return headerView
    }()
    
    var viewModel: CategoriesDetailsViewModel!
    private var subscribers = Set<AnyCancellable>()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerView)
        setupHeaderViewConstraints()
        headerView.titleLabel.text = viewModel.selectedCategoryType.rawValue

        collectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: "DishesComponentCell")
        setupBindigs()
        viewModel.viewDidLoad()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           super.traitCollectionDidChange(previousTraitCollection)
           
           // Update navigation bar title text attributes based on interface style
           let titleColor: UIColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
           let titleFont = UIFont.boldSystemFont(ofSize: 25) // Adjust font size as needed
           
           configureNavigationBarTitle(title: self.title ?? "", font: titleFont, textColor: titleColor)
       }
    
    private func setupHeaderViewConstraints() {
        
        NSLayoutConstraint.activate ([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 69),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setupBindigs() {
        viewModel.isLoading
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.startLoader()
                } else {
                    self?.stopLoader()
                }
            }.store(in: &subscribers)
        
        viewModel.dishesDidLoad
            .sink { [weak self] in
                self?.collectionView.reloadData()
            }.store(in: &subscribers)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dish = viewModel.item(at: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishesComponentCell", for: indexPath) as! DishCollectionViewCell
        cell.configure(dish: dish, 
                       favouriteButtonIsHidden: false,
                       favouriteButtonTapPublisher: viewModel.favouriteButtonTapPublisher)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row, from: self)
    }
}

#Preview {
    let vc = CategoriesDetailsViewController()
    return vc
}

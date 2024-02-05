//
//  CategoriesdetailsViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//
import UIKit
import Combine

final class CategoriesDetailsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
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
        collectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: "DishesComponentCell")
        setupBindigs()
        viewModel.viewDidLoad()
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
        cell.configure(dish: dish, favouriteButtonIsHidden: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row, from: self)
    }
}

#Preview {
    let vc = CategoriesDetailsViewController()
    return vc
}

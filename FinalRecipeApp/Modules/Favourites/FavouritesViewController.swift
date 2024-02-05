//
//  FavouritesViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 01.02.24.
//
import UIKit

final class FavouritesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var viewModel: FavouritesViewModel
    
    init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel

        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: "DishesComponentCell")
        viewModel.viewDidLoad()
        collectionView.reloadData() // Reload collection view to display the fetched dishes
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishesComponentCell", for: indexPath) as! DishCollectionViewCell
        cell.configure(dish: viewModel.item(at: indexPath.row), favouriteButtonIsHidden: true)
        return cell
    }
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row, from: self)
    }
}

//#Preview {
//    let vc = FavouritesViewController()
//    return vc
//}

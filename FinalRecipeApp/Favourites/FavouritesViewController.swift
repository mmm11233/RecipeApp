//
//  FavouritesViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 01.02.24.
//
import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishesComponentCell", for: indexPath) as! FavouritesCollectionViewCell
        cell.configure(imageUrl: "your_image_url", name: "Dish Name", calorie: 300, prepareTime: 30)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 250)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(FavouritesCollectionViewCell.self, forCellWithReuseIdentifier: "DishesComponentCell")
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    let vc = CollectionViewController()
    return vc
}

//
//  FavouritesViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 01.02.24.
//

import UIKit
import Combine

// MARK: Favourites View Controller
final class FavouritesViewController: UICollectionViewController {
    
    //MARK: Properties
    private var subscribers = Set<AnyCancellable>()
    private let viewModel: FavouritesViewModel
    
    //MARK: - Initializer
    init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setUpBindings()
        setupCollectionView()
        viewModel.viewDidLoad()
    }
    
    //MARK: - Setup
    private func setupView() {
        title = "Favourited"
        view.backgroundColor = ColorBook.white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setUpBindings() {
        NotificationCenter.default.publisher(for: .updateFavourites)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.viewModel.updateDataSource()
                self?.collectionView.reloadData()
            }.store(in: &subscribers)
    }
    
    private func setupCollectionView() {
        collectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: "DishesComponentCell")
    }
}

// MARK: Collection View Delegate Flow Layout
extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishesComponentCell", for: indexPath) as! DishCollectionViewCell
        cell.configure(model: .init(dish: viewModel.item(at: indexPath.row),
                                    favouriteButtonIsHidden: false,
                                    favouriteButtonTapPublisher: viewModel.favouriteButtonTapPublisher))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 191, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row, from: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}

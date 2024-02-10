//
//  FavouritesViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 01.02.24.
//
import UIKit
import Combine

final class FavouritesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var subscribers = Set<AnyCancellable>()
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
        setupView()
        setUpBindings()
        viewModel.viewDidLoad()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "White")
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favourited"
    }
    
    private func setUpBindings() {
        NotificationCenter.default.publisher(for: .updateFavourites)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.viewModel.updateDataSource()
                self?.collectionView.reloadData()
            }.store(in: &subscribers)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishesComponentCell", for: indexPath) as! DishCollectionViewCell
        cell.configure(model: .init(dish: viewModel.item(at: indexPath.row),
                                    favouriteButtonIsHidden: false,
                                    favouriteButtonTapPublisher: viewModel.favouriteButtonTapPublisher))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 191, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row, from: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Return the minimum line spacing for the section
        return 20// Adjust this value according to your needs
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        // Return the minimum interitem spacing for the section
//        return 10// Adjust this value according to your needs
//    }
}

//#Preview {
//    let vc = FavouritesViewController(viewModel: )
//    return vc
//}

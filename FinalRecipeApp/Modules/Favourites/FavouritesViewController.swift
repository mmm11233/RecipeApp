//
//  FavouritesViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 01.02.24.
//
import UIKit
import Combine

final class FavouritesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        return headerView
    }()
    
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
        view.addSubview(headerView)
        setupHeaderViewConstraints()
        headerView.titleLabel.text = "Favourited"
        switch traitCollection.userInterfaceStyle {
            
        case .unspecified, .light:
            view.backgroundColor = UIColor.white
            
        case .dark:
            view.backgroundColor = UIColor.black
            
        @unknown default:
            break
        }
        
        collectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: "DishesComponentCell")
        setUpBindings()
        viewModel.viewDidLoad()
    }
    
    private func setupHeaderViewConstraints() {
        
        NSLayoutConstraint.activate ([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 69),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 30),
        ])
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
        cell.configure(dish: viewModel.item(at: indexPath.row),
                       favouriteButtonIsHidden: false,
                       favouriteButtonTapPublisher: viewModel.favouriteButtonTapPublisher)
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

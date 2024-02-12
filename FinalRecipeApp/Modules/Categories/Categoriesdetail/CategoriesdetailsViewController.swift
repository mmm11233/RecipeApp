//
//  CategoriesdetailsViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//
import UIKit
import Combine

final class CategoriesDetailsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    var viewModel: CategoriesDetailsViewModel!
    private var subscribers = Set<AnyCancellable>()
    
    //MARK: - Init
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White")
        title = viewModel.selectedCategoryType.rawValue
        
        collectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: "DishesComponentCell")
        setupBindigs()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Methods
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
        
        viewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dish = viewModel.item(at: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishesComponentCell", for: indexPath) as! DishCollectionViewCell
        cell.configure(model: .init(dish: dish,
                                    favouriteButtonIsHidden: false,
                                    favouriteButtonTapPublisher: viewModel.favouriteButtonTapPublisher))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: 190, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.didSelectRowAt(at: indexPath.row, from: self)
    }
}

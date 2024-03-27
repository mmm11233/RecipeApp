//
//  CategoriesdetailsViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 04.02.24.
//
import UIKit
import Combine

// MARK: - Categories Details View Controller
final class CategoriesDetailsViewController: UICollectionViewController {
    //MARK: Properties
    private var subscribers = Set<AnyCancellable>()
    private let viewModel: CategoriesDetailsViewModel
    
    //MARK: - Init
    init(viewModel: CategoriesDetailsViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupBindigs()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = ColorBook.white
        title = viewModel.selectedCategoryType.rawValue
    }
    
    private func setupCollectionView() {
        collectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: "DishesComponentCell")
        setupRefreshControl()
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
        
        viewModel.dishesDidLoadPublisher
            .sink { [weak self] in
                self?.collectionView.reloadData()
                self?.dismissCollectionViewViewLoader()
            }.store(in: &subscribers)
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged(sender:)), for: .valueChanged)
    }
    
    private func dismissCollectionViewViewLoader() {
        collectionView.refreshControl?.endRefreshing()
    }
    
    // MARK: User Interaction
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        viewModel.reloadData()
    }
}

// MARK: Collection View Delegate Flow Layout
extension CategoriesDetailsViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishesComponentCell", for: indexPath) as! DishCollectionViewCell
        cell.configure(model: .init(dish: viewModel.item(at: indexPath.row),
                                    favouriteButtonIsHidden: false,
                                    favouriteButtonTapPublisher: viewModel.favouriteButtonTapSubject))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 190, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row, from: self)
    }
}

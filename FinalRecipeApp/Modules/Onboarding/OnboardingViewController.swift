//
//  FirstOnboarding.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.03.24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    private var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        return backgroundView
    }()
    
    private let mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to Main", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        //        button.addTarget(self, action: #selector(mapButtonTapped(_:)), for: .touchUpInside)
        button.backgroundColor = ColorBook.orange.withAlphaComponent(0.9)
        button.layer.cornerRadius = 12
        button.setTitleColor(ColorBook.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var viewModel: OnboardingViewModel
    
    // MARK: - Inits
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.setup()
        setupUI()
        setupCollectionView()
        setupConstraints()
    }
    
    // MARK: - Configure
    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(mainButton)
        
        backgroundView.backgroundColor = Constants.colorsDataSource.first
        pageControl.numberOfPages = viewModel.items.count
        pageControl.currentPageIndicatorTintColor = ColorBook.orange
        pageControl.pageIndicatorTintColor = ColorBook.black.withAlphaComponent(0.16)
    }
    
    private func setupCollectionView() {
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -240),
            
            
            mainButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 30),
            mainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            mainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
        ])
    }
    
    private func updateBackgroundColor() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        backgroundView.layer.removeAllAnimations()
        backgroundView.layer.add(transition, forKey: nil)
        
        backgroundView.backgroundColor = Constants.colorsDataSource[viewModel.currentPage]
    }
    
    func pageControlAction() {
        viewModel.currentPage = pageControl.currentPage
        updateBackgroundColor()
        let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}




//MARK: - Extensions
extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.items[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        if let indexPath = collectionView.indexPathForItem(at: visiblePoint) {
            viewModel.currentPage = indexPath.row
            updateBackgroundColor()
            pageControl.currentPage = viewModel.currentPage
        }
    }
}

extension OnboardingViewController {
    enum Constants {
        static let colorsDataSource: [UIColor] = [
            ColorBook.pink,
            ColorBook.lightGray,
            ColorBook.gray
        ]
    }
}

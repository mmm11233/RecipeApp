//
//  CategoriesViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.01.24.
//
import UIKit
import Combine

// MARK: - Categories View Controller
final class CategoriesViewController: UIViewController {
    // MARK: Properties
    private let viewModel: CategoriesViewModel
    private var subscribers = Set<AnyCancellable>()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        return headerView
    }()
    
    // MARK: Initalizer
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupConstraints()
        setupBindigs()
        viewModel.viewDidLoad()
    }
    
    // MARK: Setup
    private func setupView() {
        headerView.configure(title: "Categories")
        
        view.backgroundColor = ColorBook.white
        view.addSubview(headerView)
        view.addSubview(tableView)
    }
    
    private func setupBindigs() {
        viewModel.isLoading
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.startLoader()
                } else {
                    self?.stopLoader()
                    self?.dismissTableViewViewLoader()
                }
            }.store(in: &subscribers)
        
        viewModel.categoriesDidLoadPublisher
            .sink { [weak self] in
                self?.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 26),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        setupRefreshControl()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategrorieTableViewCell")
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged(sender:)), for: .valueChanged)
    }
    
    private func dismissTableViewViewLoader() {
        tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: User Interaction
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        viewModel.refreshData()
    }
}

// MARK: Table View Data Source And Delegate
extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = viewModel.item(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategrorieTableViewCell", for: indexPath)
        
        if let categoriesViewControllerCell = cell as? CategoryTableViewCell {
            categoriesViewControllerCell.configure(with: category)
            return categoriesViewControllerCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row, from: self)
    }
}

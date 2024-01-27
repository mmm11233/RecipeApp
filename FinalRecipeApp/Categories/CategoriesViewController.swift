//
//  CategoriesViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.01.24.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = CategoriesViewModel()
    
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
        
    // MARK: - Private LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.backgroundColor = .white
        setupTableView()
        setupTableViewConstraints()
        headerView.titleLabel.text = "Categories"
    }
    
    // MARK: - Private Methods
    private func setupTableViewConstraints() {
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 69),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 26),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CategrorieTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = viewModel.categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let categoriesViewControllerCell = cell as? CategrorieTableViewCell {
            categoriesViewControllerCell.configure(with: category)
            return categoriesViewControllerCell
        }
        return cell
    }
}

#Preview {
    let vc = CategoriesViewController()
    return vc
}

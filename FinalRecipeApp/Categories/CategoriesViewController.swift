//
//  CategoriesViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.01.24.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let categories = Categories.dummyData
    
    // MARK: - Private LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.backgroundColor = .white
        setupTableView()
        setupTableViewConstraints()
    }
    
    // MARK: - Private Methods
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CategroriesTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categories = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let categoriesViewControllerCell = cell as? CategroriesTableViewCell {
            categoriesViewControllerCell.configure(with: categories)
            return categoriesViewControllerCell
        }
        return cell
    }
    

}

#Preview {
    let vc = CategoriesViewController()
    return vc
}

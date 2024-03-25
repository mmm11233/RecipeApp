//
//  ShoppingListViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 24.03.24.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: ShoppingListViewModel
    
    init(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var name: [String] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupConstraints()
    }
    
    // MARK: - Methods
    private func setupView() {
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(save))
        
        view.backgroundColor = ColorBook.white
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "ShoppingListTableViewCell")
    }
    
    @objc func save() {
        let alertController = UIAlertController(title: "Add shopping items", message: "write items in the textField", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter text"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alertController.textFields?.first, let sthToAdd = textField.text else { return }
            print("Text to add:", sthToAdd)
            
            self.name.append(sthToAdd)
            tableView.reloadData()
        }
    
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
//        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Extensions
extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath)
        
        if let shoppingListViewControllerCell = cell as? ShoppingListTableViewCell {
            shoppingListViewControllerCell.configure(with: item)
            return shoppingListViewControllerCell
        }
        
        return cell
    }
    
}


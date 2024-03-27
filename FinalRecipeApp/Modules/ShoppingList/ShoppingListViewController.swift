//
//  ShoppingListViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 24.03.24.
//

import UIKit
import Combine

// MARK: - Shopping List View Controller
final class ShoppingListViewController: UIViewController {
    // MARK: Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isUserInteractionEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var noEntriesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = ColorBook.black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "There is no items"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var subscribers = Set<AnyCancellable>()
    
    private let viewModel: ShoppingListViewModel
    
    // MARK: Initalizer
    init(viewModel: ShoppingListViewModel) {
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
        setupBindings()
        viewModel.viewDidLoad()
    }
    
    // MARK: Setup
    private func setupBindings() {
        viewModel.itemsDidUpdatePublisher
            .sink { [weak self] in
                self?.tableView.reloadData()
            }.store(in: &subscribers)
        
        viewModel.noEntriesFoundPublisher
            .sink { [weak self] text in
                self?.updateNoEntriesFoundLabel(text: text)
            }.store(in: &subscribers)
    }
    
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
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "ShoppingListTableViewCell")
    }
    
    private func updateNoEntriesFoundLabel(text: String?) {
        if let text = text {
            tableView.setEmptyView(title: text)
        } else {
            tableView.restoreEmptyView()
        }
    }
    
    // MARK: User Interaction
    @objc func save() {
        let alertController = UIAlertController(title: "Add shopping item", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter text"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alertController.textFields?.first, let sthToAdd = textField.text else { return }
            print("Text to add:", sthToAdd)
            if !sthToAdd.isEmpty {
                viewModel.save(item: sthToAdd)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showDeleteWarning(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "Warning Title", message: "Warning Message", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            DispatchQueue.main.async {
                self.viewModel.delete(indexPath: indexPath)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: Table View DataSource And Delegate
extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath)
        
        if let shoppingListCell = cell as? ShoppingListTableViewCell {
            shoppingListCell.configure(with: item)
            shoppingListCell.delegate = self
            return shoppingListCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title:  "Delete", handler: { _, _, _ in
            DispatchQueue.main.async {
                self.showDeleteWarning(for: indexPath)
            }
        })
        
        modifyAction.image = UIImage(named: "delete")
        modifyAction.backgroundColor = .purple
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
}

// MARK: Shopping List Table View Cell Delegate
extension ShoppingListViewController: ShoppingListTableViewCellDelegate {
    func markButtonTapped(cell: ShoppingListTableViewCell, isMarked: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            viewModel.update(indexPath: indexPath, isMarked: isMarked)
        }
    }
    
    func shoppingItemdDidChange(cell: ShoppingListTableViewCell, newValue: String) {
        if let indexPath = tableView.indexPath(for: cell) {
            viewModel.update(indexPath: indexPath, newValue: newValue)
        }
    }
}

//
//  ShoppingListTableViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 24.03.24.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let background: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var shoppingItem: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura Condensed Medium", size: 20)
        label.textColor = ColorBook.primaryBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let markButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to Main", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.addTarget(ShoppingListTableViewCell.self, action: #selector(markButtonTapped(_:)), for: .touchUpInside)
        button.backgroundColor = ColorBook.orange.withAlphaComponent(0.9)
        button.layer.cornerRadius = 12
        button.setTitleColor(ColorBook.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        shoppingItem.text = nil
    }
    
    // MARK: - Configure
    //    func configure(with model: Category) {
    //        categoryName.text = model.type.rawValue
    //        categoryImage.image = model.type.image
    //    }
    
    // MARK: - Methods
    private func setupView() {
        background.backgroundColor = ColorBook.lightGray
        background.layer.cornerRadius = 20
        
        background.layer.shadowColor = ColorBook.gray.cgColor
        background.layer.shadowOpacity = 0.5
        background.layer.shadowOffset = CGSize(width: 0, height: 2)
        background.layer.shadowRadius = 4
    }
    
    private func addSubviews() {
        addSubview(background)
        background.addSubview(shoppingItem)
        background.addSubview(markButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            background.heightAnchor.constraint(equalToConstant: 55),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            shoppingItem.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            shoppingItem.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            
            markButton.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            markButton.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            markButton.heightAnchor.constraint(equalToConstant: 10),
            markButton.widthAnchor.constraint(equalToConstant: 10)
            
        ])
    }
    
    @objc func markButtonTapped(_ sender: UIButton) {
        
    }
}

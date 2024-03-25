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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private var isMarked: Bool = false
    
    private lazy var markButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(markButtonTapped), for: .touchUpInside)
        button.setImage(ImageBook.Icons.circle, for: .normal)
        button.setImage(ImageBook.Icons.checkMark, for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = ColorBook.primaryWhite
        button.layer.cornerRadius = 7.0
        button.layer.masksToBounds = true
        button.isSelected = isMarked
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    @objc func markButtonTapped(_ sender: UIButton) {
        isMarked.toggle()
        
    }
    
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
        func configure(with model: String) {

            shoppingItem.text = "mariami"
        }
    
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
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
    
            
            shoppingItem.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
            shoppingItem.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 8),
            shoppingItem.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            shoppingItem.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -8),
            

            markButton.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            markButton.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -12),
            markButton.heightAnchor.constraint(equalToConstant: 20),
            markButton.widthAnchor.constraint(equalToConstant: 20)
            
        ])
    }
}

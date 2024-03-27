//
//  ShoppingListTableViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 24.03.24.
//

import UIKit

// MARK: Shopping List Table View Cell Delegate
protocol ShoppingListTableViewCellDelegate: AnyObject {
    func shoppingItemdDidChange(cell: ShoppingListTableViewCell, newValue: String)
    func markButtonTapped(cell: ShoppingListTableViewCell, isMarked: Bool)
}

// MARK: - Shopping List Table View Cell Delegate
final class ShoppingListTableViewCell: UITableViewCell {
    // MARK: Properties
    private let background: UIView = {
        let view: UIView = .init()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Futura Condensed Medium", size: 20)
        textField.textColor = ColorBook.primaryBlack
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let markButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(markButtonTapped), for: .touchUpInside)
        button.setImage(ImageBook.Icons.checkMark, for: .normal)
        button.setImage(ImageBook.Icons.checkMarkFill, for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = ColorBook.primaryWhite
        button.layer.cornerRadius = 7.0
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: ShoppingListTableViewCellDelegate?
    
    // MARK: - Initializer
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
    
    // MARK: PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textField.text = nil
    }
    
    // MARK: Configuration
    func configure(with item: ShopingItem) {
        textField.text = item.title
        markButton.isSelected = item.isMarked
    }
    
    // MARK: Setup
    private func setupView() {
        background.backgroundColor = ColorBook.lightGray
        background.layer.cornerRadius = 20
        
        background.layer.shadowColor = ColorBook.gray.cgColor
        background.layer.shadowOpacity = 0.5
        background.layer.shadowOffset = CGSize(width: 0, height: 2)
        background.layer.shadowRadius = 4
        
        textField.delegate = self
    }
    
    private func addSubviews() {
        contentView.addSubview(background)
        background.addSubview(textField)
        background.addSubview(markButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            textField.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: markButton.leadingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -8),
            
            markButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            markButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            markButton.heightAnchor.constraint(equalToConstant: 24),
            markButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: User Interaction
    @objc private func markButtonTapped(_ sender: UIButton) {
        delegate?.markButtonTapped(cell: self, isMarked: sender.isSelected)
        sender.isSelected.toggle()
    }
}

// MARK: Text Field Delegate
extension ShoppingListTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.shoppingItemdDidChange(cell: self, newValue: textField.text ?? "")
        endEditing(true)
        return true
    }
}

//
//  ShoppingListTableViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 24.03.24.
//

import UIKit

protocol ShoppingListTableViewCellDelegate: AnyObject {
    func shoopingItemdDidChange(cell: ShoppingListTableViewCell, newValue: String)
    func markButtonTapped(cell: ShoppingListTableViewCell, isMarked: Bool)
}

final class ShoppingListTableViewCell: UITableViewCell, UITextFieldDelegate{
    
    // MARK: - Properties
    private var isMarked: Bool = false
    weak var delegate: ShoppingListTableViewCellDelegate?
    
    private let background: UIView = {
        let view: UIView = .init()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Futura Condensed Medium", size: 20)
        textField.textColor = ColorBook.primaryBlack
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()

    private lazy var markButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(markButtonTapped), for: .touchUpInside)
        button.setImage(ImageBook.Icons.checkMark, for: .normal)
        button.setImage(ImageBook.Icons.checkMarkFill, for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = ColorBook.primaryWhite
        button.layer.cornerRadius = 7.0
        button.layer.masksToBounds = true
        button.isSelected = isMarked
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc private func markButtonTapped(_ sender: UIButton) {
        isMarked.toggle()
        sender.isSelected = isMarked
        delegate?.markButtonTapped(cell: self, isMarked: isMarked)
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
        
        textField.text = nil
    }
    
    // MARK: - Configure
    func configure(with item: ShopingItem) {
        textField.text = item.title
        markButton.isSelected = item.isMarked
    }
    
    // MARK: - Methods
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.shoopingItemdDidChange(cell: self, newValue: textField.text ?? "")
        endEditing(true)
        return true
    }
}

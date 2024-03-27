//
//  CategroriesTableViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.01.24.
//

import UIKit

// MARK: - Category Table View Cell
final class CategoryTableViewCell: UITableViewCell {
    // MARK: Properties
    private let background: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura Condensed Medium", size: 20)
        label.textColor = ColorBook.primaryBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    // MARK: Initializer
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
    
    // MARK: - Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryName.text = nil
        categoryImage.image = nil
    }
    
    // MARK: Configuration
    func configure(with model: Category) {
        categoryName.text = model.type.rawValue
        categoryImage.image = model.type.image
    }
    
    // MARK: Setup
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
        background.addSubview(categoryName)
        background.addSubview(categoryImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            background.heightAnchor.constraint(equalToConstant: 55),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            categoryName.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            categoryName.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            
            categoryImage.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            categoryImage.heightAnchor.constraint(equalToConstant: 40),
            categoryImage.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}

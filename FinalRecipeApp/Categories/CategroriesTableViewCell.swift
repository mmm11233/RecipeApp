//
//  CategroriesTableViewCell.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 19.01.24.
//

import UIKit

final class CategroriesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .center
        
        return stackView
    }()
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura Condensed Medium", size: 20)
        label.textColor = .black
        
        return label
    }()
    
    private var categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
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
        
        categoryName.text = nil
        categoryImage.image = nil
    }
    
    // MARK: - Configure
    func configure(with model: Categories) {
        categoryName.text = model.name
        categoryImage.image = model.image
    }
    
    // MARK: - Private Methods
    private func setupView() {
        mainStackView.backgroundColor = UIColor(hexString: "F6F6F6")
        mainStackView.layer.cornerRadius = 20
        
        mainStackView.layer.shadowColor = UIColor.gray.cgColor
        mainStackView.layer.shadowOpacity = 0.5
        mainStackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainStackView.layer.shadowRadius = 4
    }
    
    private func addSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(categoryName)
        mainStackView.addArrangedSubview(categoryImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -9),
            
            categoryName.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor),
            categoryName.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 16),
            
            categoryImage.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor),
            categoryImage.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -9),
            categoryImage.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 5),
            categoryImage.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 240)
        ])
    }
}

#Preview {
    let cell = CategroriesTableViewCell()
    cell.configure(with: .init(name: "name", image: UIImage(named: "image 1")!))
    return cell
}

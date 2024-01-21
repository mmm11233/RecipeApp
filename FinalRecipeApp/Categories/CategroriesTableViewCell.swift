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
            mainStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
            mainStackView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -14),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            
            categoryImage.heightAnchor.constraint(equalToConstant: 50),
            categoryImage.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}

#Preview {
    let cell = CategroriesTableViewCell()
    cell.configure(with: .init(name: "name", image: UIImage(named: "image 1")!))
    return cell
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

//
//  StockCell.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 23.05.2022.
//

import UIKit

final class StockCell: UITableViewCell {
    private var favoriteAction: (() -> Void)?
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.image = UIImage(named: "YNDX")
        return image
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.text = "YNDX"
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Yandex, LLC"
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "4 764,6 ₽"
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var changeLabel: UILabel = {
        let label = UILabel()
        label.text = "+55 ₽ (1,15%)"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite-off"), for: .normal)
        button.setImage(.checkmark, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonTap), for: .touchUpInside)
        return button
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let priceContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        favoriteAction = nil
    }
    
    func configure(with model: StockModelProtocol) {
        symbolLabel.text = model.symbol
        companyLabel.text = model.name
        priceLabel.text = model.price
        favoriteButton.isSelected = model.isFavotite
        favoriteAction = {
            model.setFavorite()
        }
    }
    
    @objc private func favoriteButtonTap() {
        favoriteButton.isSelected.toggle()
        favoriteAction?()
    }
    
    private func setupContentView() {
        contentView.addSubview(iconView)
        contentView.addSubview(titleContainerView)
        contentView.addSubview(priceContainerView)
        
        iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        
        titleContainerView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12).isActive = true
        titleContainerView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        titleContainerView.trailingAnchor.constraint(lessThanOrEqualTo: priceContainerView.leadingAnchor,
                                                     constant: -20).isActive = true
        
        priceContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        priceContainerView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        
        setupTitleContainerView()
        setupPriceContainerView()
    }
    
    private func setupTitleContainerView() {
        titleContainerView.addSubview(symbolLabel)
        titleContainerView.addSubview(companyLabel)
        titleContainerView.addSubview(favoriteButton)
        
        symbolLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor).isActive = true
        
        favoriteButton.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: symbolLabel.centerYAnchor).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        favoriteButton.trailingAnchor.constraint(lessThanOrEqualTo: titleContainerView.trailingAnchor).isActive = true
        
        companyLabel.leadingAnchor.constraint(equalTo: symbolLabel.leadingAnchor).isActive = true
        companyLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor).isActive = true
        companyLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor).isActive = true
        companyLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor).isActive = true
    }
    
    private func setupPriceContainerView() {
        priceContainerView.addSubview(priceLabel)
        priceContainerView.addSubview(changeLabel)

        priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: priceContainerView.leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: priceContainerView.trailingAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: priceContainerView.topAnchor).isActive = true
        
        changeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: priceContainerView.leadingAnchor).isActive = true
        changeLabel.trailingAnchor.constraint(equalTo: priceContainerView.trailingAnchor).isActive = true
        changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor).isActive = true
        changeLabel.bottomAnchor.constraint(equalTo: priceContainerView.bottomAnchor).isActive = true
    }
}
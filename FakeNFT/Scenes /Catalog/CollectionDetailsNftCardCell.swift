//
//  CollectionDetailsNftCardCell.swift
//  FakeNFT
//
//  Created by Chingiz on 09.05.2024.
//

import UIKit
import Kingfisher

final class CollectionDetailsNftCardCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "CollectionDetailsNftCardCell"
    
    // MARK: - Private Properties
    
    private var itemId: String = ""
    private var isItemInCart: Bool = false
    private var isItemLiked: Bool = false
    
    private lazy var nftCardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "NFTcard")
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "heart.fill"),
            for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        
        let arrOfStars: [UIImageView] = (0..<5).map { _ in
            let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
        
        arrOfStars.forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var containerView = UIView()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.text = "Archie"
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.text = "3,14 ETH"
        return label
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .cartAdd).withTintColor(.label), for: .normal)
        button.addTarget(self, action: #selector(cartTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func likeTapped() {
        // TODO: - Catalog Module 3: User Interaction
    }
    
    @objc private func cartTapped() {
        // TODO: - Catalog Module 3: User Interaction
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        
        [
            nftCardImageView,
            likeButton,
            ratingStackView,
            containerView
        ]
            .forEach {
                subview in
                contentView.addSubview(subview)
                subview.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            
            nftCardImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftCardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftCardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftCardImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            ratingStackView.topAnchor.constraint(equalTo: nftCardImageView.bottomAnchor, constant: 8),
            ratingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -21)
        ])
        
        [
            nameLabel,
            priceLabel,
            cartButton
        ]
            .forEach {
                subview in
                containerView.addSubview(subview)
                subview.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            
            cartButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cartButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            cartButton.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor)
        ])
    }
    
    func configure(data: CollectionCellModel) {
        nftCardImageView.kf.setImage(with: data.image)
        nameLabel.text = data.name
        setRatingStars(data.rating)
        let priceString = String(format: "%.2f", data.price)
        priceLabel.text = priceString + " ETH"
        itemId = data.id
        setLikeButtonState(isLiked: data.isLiked)
        setCartButtonState(isAdded: data.isAddedToCart)
    }
    
    private func setLikeButtonState(isLiked: Bool) {
        if isLiked {
            likeButton.tintColor = UIColor(hexString: "F56B6C")
        } else {
            likeButton.tintColor = .white
        }
    }
    
    private func setCartButtonState(isAdded: Bool) {
        if isAdded {
            cartButton.setImage(UIImage(named: "cartDelete")?.withTintColor(.label), for: .normal)
        } else {
            cartButton.setImage(UIImage(named: "cartAdd")?.withTintColor(.label), for: .normal)
        }
    }
    
    private func setRatingStars(_ rating: Int) {
        guard let arrangedSubviews = ratingStackView.arrangedSubviews as? [UIImageView] else {
            return
        }
        
        for (index, starImageView) in arrangedSubviews.enumerated() {
            if index < rating {
                starImageView.tintColor = UIColor(hexString: "FEEF0D")
            } else {
                starImageView.tintColor = .segmentInactive
            }
        }
    }
}


//
//  MyNFTCell.swift
//  FakeNFT
//
//  Created by Chalkov on 13.05.2024.
//

import UIKit

final class MyNFTCell: UITableViewCell, ReuseIdentifying {

    var currentIndexPath: IndexPath?

    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like-off")
        imageView.widthAnchor.constraint(equalToConstant: 42).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        return imageView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold
        label.textColor = .black
        return label
    }()
    
    private lazy var ratingStackView = RatingView()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption2
        label.textColor = .black
        return label
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption2
        label.text = "Цена"
        label.textColor = .black
        return label
    }()
    
    private lazy var priceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold
        label.textColor = .black
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(nftImageView)
        contentView.addSubview(likeImageView)
        contentView.addSubview(contentStackView)
        contentView.addSubview(priceStackView)
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(ratingStackView)
        contentStackView.addArrangedSubview(authorLabel)
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(priceValueLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nftImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            
            likeImageView.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 0),
            likeImageView.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 0),
            
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 144),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -128),
            ratingStackView.heightAnchor.constraint(equalToConstant: 12),
           
            priceStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -39)
        ])
    }
    
    // MARK: - Public
    
    func update(_ item: Item) {
        nameLabel.text = item.name
        priceValueLabel.text = String(format: "%.2f ETH", item.price)
        authorLabel.text = "от \(item.author)"
        ratingStackView.setupRating(rating: item.rating)
        guard
            let imageUrlString = item.images.first,
            let imageUrl = URL(string: imageUrlString)
        else { return }
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: imageUrl) { [weak self] _ in
            self?.nftImageView.kf.indicatorType = .none
        }
    }
}

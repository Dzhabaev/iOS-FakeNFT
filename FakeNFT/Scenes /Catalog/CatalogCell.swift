//
//  CatalogCell.swift
//  FakeNFT
//
//  Created by Chingiz on 22.04.2024.
//

import Kingfisher
import UIKit

// MARK: - CatalogCell

final class CatalogCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "CatalogCell"
    
    // MARK: - Private Properties
    
    private lazy var coverCollectionImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        image.image = defaultImage
        return image
    }()
    
    private lazy var collectionTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .segmentActive
        label.font = .bodyBold
        label.text = "Empty catalog (0)"
        return label
    }()
    
    private lazy var defaultImage: UIImage? = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        gradientLayer.colors = [
            UIColor(hexString: "#AEAFB4").withAlphaComponent(1.0).cgColor,
            UIColor(hexString: "#AEAFB4").withAlphaComponent(0.3).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with catalog: CatalogModel) {
        loadingIndicator.startAnimating()
        if let url = URL(string: catalog.cover) {
            coverCollectionImage.kf.setImage(with: url) { [weak self] result in
                switch result {
                case .success(_):
                    guard let self = self else { return }
                    self.loadingIndicator.stopAnimating()
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                    self?.loadingIndicator.stopAnimating()
                }
            }
        } else {
            loadingIndicator.stopAnimating()
            coverCollectionImage.image = defaultImage
        }
        collectionTitleLabel.text = "\(catalog.name) (\(catalog.count))"
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        [
            coverCollectionImage,
            collectionTitleLabel,
            loadingIndicator
        ]
            .forEach {
                subview in
                contentView.addSubview(subview)
                subview.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            coverCollectionImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            coverCollectionImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            coverCollectionImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            coverCollectionImage.heightAnchor.constraint(equalToConstant: 140),
            
            
            collectionTitleLabel.topAnchor.constraint(equalTo: coverCollectionImage.bottomAnchor, constant: 4),
            collectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: coverCollectionImage.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: coverCollectionImage.centerYAnchor)
        ])
    }
}

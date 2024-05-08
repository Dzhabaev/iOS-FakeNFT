//
//  CollectionDetailsViewController.swift
//  FakeNFT
//
//  Created by Chingiz on 25.04.2024.
//

import UIKit

// MARK: - CollectionDetailsViewController

final class CollectionDetailsViewController: UIViewController {
    
    var collection: CatalogModel? {
        didSet {
            if let collection = collection {
                configure(with: collection,
                          imageLoader: CatalogProviderImpl(networkClient: DefaultNetworkClient())
                )
            }
        }
    }
    
    
    // MARK: - Private Properties
    
    private let presenter: CollectionDetailsViewControllerPresenter
    
    private lazy var coverCollectionImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        image.layer.cornerRadius = 12
        image.image = defaultImage
        return image
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
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        gradientLayer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(systemName: "chevron.backward") {
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            button.setImage(tintedImage, for: .normal)
            button.tintColor = .closeButton
        }
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var collectionTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .segmentActive
        label.font = .headline3
        return label
    }()
    
    private lazy var authorCollectionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .segmentActive
        label.font = .caption2
        label.text = NSLocalizedString("authorCollectionLabel.text", comment: "")
        return label
    }()
    
    private lazy var authorLinkLabel: UILabel = {
        let label = UILabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(authorLinkTapped))
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .hyperlinkText
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var descriptionCollectionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .segmentActive
        label.font = .caption2
        return label
    }()
    
    // MARK: - Initializers
    
    init(presenter: CollectionDetailsViewControllerPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        presenter.viewController = self
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func authorLinkTapped() {
        presenter.authorLinkTapped()
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        
        view.backgroundColor = .backgroundColorActive
        
        [
            coverCollectionImage,
            backButton,
            loadingIndicator,
            collectionTitleLabel,
            authorCollectionLabel,
            authorLinkLabel,
            descriptionCollectionLabel
        ]
            .forEach {
                subview in
                view.addSubview(subview)
                subview.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            coverCollectionImage.topAnchor.constraint(equalTo: view.topAnchor),
            coverCollectionImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverCollectionImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coverCollectionImage.heightAnchor.constraint(equalToConstant: 310),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: coverCollectionImage.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: coverCollectionImage.centerYAnchor),
            
            collectionTitleLabel.topAnchor.constraint(equalTo: coverCollectionImage.bottomAnchor, constant: 16),
            collectionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            authorCollectionLabel.topAnchor.constraint(equalTo: collectionTitleLabel.bottomAnchor, constant: 13),
            authorCollectionLabel.leadingAnchor.constraint(equalTo: collectionTitleLabel.leadingAnchor),
            
            authorLinkLabel.leadingAnchor.constraint(equalTo: authorCollectionLabel.trailingAnchor, constant: 4),
            authorLinkLabel.bottomAnchor.constraint(equalTo: authorCollectionLabel.bottomAnchor),
            
            descriptionCollectionLabel.topAnchor.constraint(equalTo: authorCollectionLabel.bottomAnchor, constant: 5),
            descriptionCollectionLabel.leadingAnchor.constraint(equalTo: collectionTitleLabel.leadingAnchor),
            descriptionCollectionLabel.trailingAnchor.constraint(equalTo: collectionTitleLabel.trailingAnchor)
        ])
    }
    
    private func configure(with catalog: CatalogModel, imageLoader: ImageLoader) {
        loadingIndicator.startAnimating()
        if let url = URL(string: catalog.cover) {
            imageLoader.loadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.loadingIndicator.stopAnimating()
                    self.coverCollectionImage.image = image ?? self.defaultImage
                }
            }
        } else {
            loadingIndicator.stopAnimating()
            coverCollectionImage.image = defaultImage
        }
        collectionTitleLabel.text = catalog.name
        authorLinkLabel.text = catalog.author
        descriptionCollectionLabel.text = catalog.description
    }
}

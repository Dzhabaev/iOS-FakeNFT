//
//  CollectionDetailsViewController.swift
//  FakeNFT
//
//  Created by Chingiz on 25.04.2024.
//

import UIKit

// MARK: - CollectionDetailsViewController

final class CollectionDetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    
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
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        
        view.backgroundColor = .backgroundColorActive
        
        [
            backButton
        ]
            .forEach {
                subview in
                view.addSubview(subview)
                subview.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}

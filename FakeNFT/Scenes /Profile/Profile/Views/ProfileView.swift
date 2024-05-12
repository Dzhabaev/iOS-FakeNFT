//
//  ProfileView.swift
//  FakeNFT
//
//  Created by Chalkov on 06.05.2024.
//

import UIKit

final class ProfileView: UIView {
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.headline3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.caption2
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var websiteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.caption1
        label.textColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileView {
    
    func update(_ profile: Profile?) {
        
        guard let profile else { return }
        
        fullNameLabel.text = profile.name
        descriptionLabel.text = profile.description
        websiteLabel.text = profile.website
        let url = URL(string: profile.avatar)
        profileImageView.kf.setImage(with: url)
    }
}

extension ProfileView {
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            horizontalStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            horizontalStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 20),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            websiteLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            websiteLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            websiteLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16),
            websiteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false

        horizontalStackView.addArrangedSubview(profileImageView)
        horizontalStackView.addArrangedSubview(fullNameLabel)
        
        self.addSubview(horizontalStackView)
        self.addSubview(descriptionLabel)
        self.addSubview(websiteLabel)
    }
}

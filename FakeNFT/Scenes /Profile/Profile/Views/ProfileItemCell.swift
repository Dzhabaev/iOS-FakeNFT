//
//  ProfileItemCell.swift
//  FakeNFT
//
//  Created by Chalkov on 06.05.2024.
//

import UIKit

final class ProfileItemCell: UITableViewCell {
    
    static let reusdeId = "ProfileItemCell"
    
    private var itemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var disclosureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "disclosure")
        imageView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ profileItem: ProfileItem) {
        itemLabel.text = profileItem.name
    }
    
    private func setupViews() {
        selectionStyle = .none
        [itemLabel, disclosureImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            itemLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            itemLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            itemLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            disclosureImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            disclosureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

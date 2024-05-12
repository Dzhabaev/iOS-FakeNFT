//
//  ProfileWebsiteCell.swift
//  FakeNFT
//
//  Created by Chalkov on 06.05.2024.
//

import UIKit

final class ProfileWebsiteCell: UITableViewCell {
    
    static let reusdeId = "ProfileWebsiteCell"
    
    var onProfileWebsiteChanged: ((String)->())?
    
    private var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "Сайт"
        label.font = UIFont.headline3
        return label
    }()
    
    private lazy var websiteTextField: TextField = {
        let textField = TextField()
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.yaLightGrayLight
        textField.font = UIFont.bodyRegular
        textField.addTarget(self, action: #selector(websiteTextFieldChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clear"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 17).isActive = true
        button.heightAnchor.constraint(equalToConstant: 17).isActive = true
        button.addTarget(nil, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    @objc func websiteTextFieldChanged(_ sender: UITextField) {
    
        let websiteText = websiteTextField.text ?? ""
        onProfileWebsiteChanged?(websiteText)
    }
    
    @objc func clearButtonTapped() {
        websiteTextField.text = ""
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ profile: Profile?) {
        websiteTextField.text = profile?.website ?? ""
    }
    
    private func setupViews() {
        selectionStyle = .none
        [itemLabel, websiteTextField, clearButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            itemLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            websiteTextField.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 8),
            websiteTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            websiteTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            websiteTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22)
        ])
        
        NSLayoutConstraint.activate([
            clearButton.centerYAnchor.constraint(equalTo: websiteTextField.centerYAnchor),
            clearButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
}

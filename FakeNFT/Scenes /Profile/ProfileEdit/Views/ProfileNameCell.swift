//
//  ProfileNameCell.swift
//  FakeNFT
//
//  Created by Chalkov on 06.05.2024.
//

import UIKit

final class ProfileNameCell: UITableViewCell {
    
    static let reusdeId = "ProfileNameCell"
    
    var onProfileNameChanged: ((String)->())?
    
    private var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.font = UIFont.headline3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: TextField = {
        let textField = TextField()
        textField.text = "Joaquin Phoenix"
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.yaLightGrayLight
        textField.font = UIFont.bodyRegular
        
        textField.addTarget(self, action: #selector(nameTextFieldChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    private var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clear"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 17).isActive = true
        button.heightAnchor.constraint(equalToConstant: 17).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clearButtonTapped() {
        print(#function)
        nameTextField.text = ""
    }
    
    func update(_ profile: Profile?) {
        nameTextField.text = profile?.name ?? ""
    }
    
    @objc func nameTextFieldChanged(_ sender: UITextField) {
        let nameText = nameTextField.text ?? ""
        onProfileNameChanged?(nameText)
    }
    
    
    private func setupViews() {
        contentView.addSubview(itemLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(clearButton)
    }
    private func setupConstraints() {
       
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            itemLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 8),
            nameTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            nameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22)
        ])
        
        NSLayoutConstraint.activate([
            clearButton.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            clearButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

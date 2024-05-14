//
//  ProfileDescriptionCell.swift
//  FakeNFT
//
//  Created by Chalkov on 06.05.2024.
//

import UIKit

final class ProfileDescriptionCell: UITableViewCell, UITextViewDelegate, ReuseIdentifying {
    
    var onProfileDescriptionChanged: ((String)->())?
    
    private var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.font = UIFont.headline3
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.heightAnchor.constraint(equalToConstant: 132).isActive = true
        textView.layer.cornerRadius = 12
        textView.clipsToBounds = true
        textView.backgroundColor = UIColor.yaLightGrayLight
        textView.font = UIFont.bodyRegular
        textView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        textView.delegate = self
        
        return textView
    }()
    
    func textViewDidChange(_ textView: UITextView) {
        let descriptionText = textView.text ?? ""
        onProfileDescriptionChanged?(descriptionText)
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
        descriptionTextView.text = profile?.description ?? ""
    }
    
    private func setupViews() {
        selectionStyle = .none
        [itemLabel, descriptionTextView].forEach {
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
            descriptionTextView.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 8),
            descriptionTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            descriptionTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22)
        ])
    }
}

//
//  UserInfoView.swift
//  FakeNFT
//
//  Created by Сергей on 23.04.2024.
//

import UIKit

protocol UserInfoViewControllerProtocol {
    var presenter: UserInfoPresenterProtocol { get set }
}

final class UserInfoView: UIViewController & UserInfoViewControllerProtocol {
    
    var presenter: UserInfoPresenterProtocol = {
        return UserInfoPresenter()
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing  = 16
        return stackView
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 28
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let descriptonText: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.lineBreakMode = .byWordWrapping
        textView.numberOfLines = 0
        textView.font = .systemFont(ofSize: 13, weight: .regular)
        return textView
    }()
    
    private lazy var webButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Перейти на сайт пользователя", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(webButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nftCollection: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(NFTTableViewCell.self, forCellReuseIdentifier: "NFTTableViewCell")
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        set()
        
    }
    
    private func setViews() {
        view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = ""
        stackView.addArrangedSubview(avatarImage)
        stackView.addArrangedSubview(nameLabel)
        [stackView, descriptonText, webButton, nftCollection].forEach {
            view.addSubview($0)
        }
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            descriptonText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptonText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptonText.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            webButton.topAnchor.constraint(equalTo: descriptonText.bottomAnchor, constant: 28),
            webButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            webButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            webButton.heightAnchor.constraint(equalToConstant: 40),
            nftCollection.topAnchor.constraint(equalTo: webButton.bottomAnchor, constant: 40),
            nftCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nftCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nftCollection.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    
    private func set() {
        avatarImage.image = presenter.object?.image
        nameLabel.text = presenter.object?.name
        descriptonText.text = presenter.object?.description
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func webButtonTapped() {
        navigationController?.pushViewController(WebViewController(), animated: true)
    }
}

extension UserInfoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NFTTableViewCell", for: indexPath) as! NFTTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.set(nftCount: presenter.object?.nftCount ?? Int())
        return cell
    }
}

extension UserInfoView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserNFTCollectionView()
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension UserInfoView: StatisticsViewControllerDelegate {
    func set(person: Person) {
        presenter.object = person
    }
}

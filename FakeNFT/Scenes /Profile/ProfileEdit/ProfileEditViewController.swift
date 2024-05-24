//
//  ProfileEditViewController.swift
//  FakeNFT
//
//  Created by Chalkov on 06.05.2024.
//

import UIKit

protocol ProfileEditViewControllerProtocol: AnyObject {
    
    var presenter: ProfileEditPresenterProtocol? { get set }
    
    func closeProfileEditScreen()
    func showSaveAlert(_ profile: ProfileModel)
}

final class ProfileEditViewController: UIViewController, ProfileEditViewControllerProtocol {
    
    enum ProfileEditType: Int, CaseIterable {
        case photo = 0
        case name
        case description
        case website
    }
    
    var presenter: ProfileEditPresenterProtocol?
    var profileProvider: ProfileProviderProtocol?
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 42).isActive = true
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.addTarget(nil, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ProfileImageCell.self)
        tableView.register(ProfileNameCell.self)
        tableView.register(ProfileDescriptionCell.self)
        tableView.register(ProfileWebsiteCell.self)
        
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

//MARK: - ProfileEditViewControllerProtocol
extension ProfileEditViewController {
    
    func closeProfileEditScreen() {
        dismiss(animated: true)
    }
    
    func showSaveAlert(_ profile: ProfileModel) {
        let alert = UIAlertController(title: "Сохранить данные профиля?", message: "", preferredStyle: .alert)
         
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] action in
            guard let self else { return }
            self.presenter?.alertSaveOkTapped(profile)
            
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { [weak self] action in
            guard let self else { return }
            self.closeProfileEditScreen()
        }))
         
        self.present(alert, animated: true)
    }
}

//MARK: - Event Handler
extension ProfileEditViewController {
    @objc func closeButtonTapped() {
        presenter?.closeButtonTapped()
    }
}

//MARK: - UITableViewDataSource
extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileEditType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = ProfileEditType(rawValue: indexPath.row)
        switch type {
        case .photo:

            let cell = ProfileImageCell()
            cell.update(presenter?.getProfile())
            
            return cell
        case .name:

            let cell = ProfileNameCell()
            cell.update(presenter?.getProfile())
            
            cell.onProfileNameChanged = { [weak self] nameText in
                guard let self else { return }
                self.presenter?.profileNameTextFieldChanged(nameText)
            }
            
            return cell
            
        case .description:

            let cell = ProfileDescriptionCell()
            cell.update(presenter?.getProfile())
            
            cell.onProfileDescriptionChanged = { [weak self] descriptionText in
                guard let self else { return }
                self.presenter?.profileDescriptionTextFieldChanged(descriptionText)
            }
            
            return cell
            
        case .website:
            
            let cell = ProfileWebsiteCell()
            cell.update(presenter?.getProfile())
            
            cell.onProfileWebsiteChanged = { [weak self] websiteText in
                guard let self else { return }
                self.presenter?.profileWebsiteTextFieldChanged(websiteText)
            }
            
            return cell
        default: return UITableViewCell()
            
        }
    }
}

extension ProfileEditViewController {
    
    private func setupViews() {
        view.backgroundColor = .white

        [tableView, closeButton].forEach {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

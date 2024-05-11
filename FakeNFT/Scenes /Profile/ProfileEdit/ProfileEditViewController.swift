//
//  ProfileEditViewController.swift
//  FakeNFT
//
//  Created by Chalkov on 06.05.2024.
//

import UIKit

protocol ProfileEditViewControllerProtocol: AnyObject {
    
    var presenter: ProfileEditPresenterProtocol? { get set }
    
    //Update View
    
    //Navigation
    func closeProfileEditScreen()
    func showSaveAlert()
}

final class ProfileEditViewController: UIViewController, ProfileEditViewControllerProtocol {
    
    enum ProfileEditType: Int, CaseIterable {
        case photo = 0
        case name
        case description
        case website
    }
    
    var profile: Profile?
    
    var presenter: ProfileEditPresenterProtocol?
    var profileProvider: ProfileProviderProtocol? //= ProfileProvider(networkClient: DefaultNetworkClient())
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 42).isActive = true
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ProfileImageCell.self, forCellReuseIdentifier: ProfileImageCell.reusdeId)
        tableView.register(ProfileNameCell.self, forCellReuseIdentifier: ProfileNameCell.reusdeId)
        tableView.register(ProfileDescriptionCell.self, forCellReuseIdentifier: ProfileDescriptionCell.reusdeId)
        tableView.register(ProfileWebsiteCell.self, forCellReuseIdentifier: ProfileWebsiteCell.reusdeId)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        presenter?.viewDidLoad()
    }
    
}

extension ProfileEditViewController {
    func update(_ profile: Profile?) {
        self.profile = profile
        tableView.reloadData()
    }
}

//MARK: - Navigation
extension ProfileEditViewController {
    
    func closeProfileEditScreen() {
        dismiss(animated: true)
    }
}

//MARK: - Event Handler
extension ProfileEditViewController {
    
    func showSaveAlert() {
        let alert = UIAlertController(title: "Сохранить данные профиля?", message: "", preferredStyle: .alert)
         
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] action in
            guard let self else { return }
            presenter?.alertSaveOkTapped(profile)
            
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { [weak self] action in
            guard let self else { return }
            self.closeProfileEditScreen()
        }))
         
        self.present(alert, animated: true)
    }
    
    @objc func closeButtonTapped() {
        presenter?.closeButtonTapped()
    }
}

//MARK: - TableView Delegate & Datasource
extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //profileItems.count
        return ProfileEditType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let type = ProfileEditType(rawValue: indexPath.row) {
            
            switch type {
                
            case .photo:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileImageCell.reusdeId, for: indexPath) as? ProfileImageCell else { return UITableViewCell() }
                cell.update(profile)
                
                return cell
            case .name:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileNameCell.reusdeId, for: indexPath) as? ProfileNameCell else { return UITableViewCell() }
                cell.update(profile)
                
                cell.onProfileNameChanged = { [weak self] nameText in
                    guard let self else { return }
                    print("->", nameText)
                    
                    self.profile?.name = nameText
                }
                
                return cell
                
            case .description:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDescriptionCell.reusdeId, for: indexPath) as? ProfileDescriptionCell else { return UITableViewCell() }
                cell.update(profile)
                
                cell.onProfileDescriptionChanged = { [weak self] descriptionText in
                    guard let self else { return }
                    
                    print("->", descriptionText)
                    
                    self.profile?.description = descriptionText
                }
                
                return cell
                
            case .website:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileWebsiteCell.reusdeId, for: indexPath) as? ProfileWebsiteCell else { return UITableViewCell() }
                cell.update(profile)
                
                cell.onProfileWebsiteChanged = { [weak self] websiteText in
                    guard let self else { return }
                    
                    print("->", websiteText)
                    
                    self.profile?.website = websiteText
                }
                
                return cell
            }
        }
        return UITableViewCell()
    }
}


extension ProfileEditViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
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

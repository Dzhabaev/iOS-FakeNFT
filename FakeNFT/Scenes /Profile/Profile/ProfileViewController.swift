//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Chalkov on 19.04.2024.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    
    var presenter: ProfilePresenterProtocol? { get set }
   
    //Update View
    func showProfile(_ profile: Profile?)
    func showProfileItems(_ profileItems: [ProfileItem])
    
    //Navigation
    func navigateToProfileEditScreen()
}

final class ProfileViewController: UIViewController, ProfileViewControllerProtocol {

    var presenter: ProfilePresenterProtocol?
   
    private var profileView = ProfileView()
    
    private var profile: Profile?
    private var profileItems: [ProfileItem] = []
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileItemCell.self, forCellReuseIdentifier: ProfileItemCell.reusdeId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
        
        presenter?.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: Notification.Name("ProfileUpdatedNotification"), object: nil, queue: nil) { notification in
            
            if let data = notification.userInfo as? [String: Profile] {
                let profile = data["profile"]
                self.showProfile(profile)
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - Update View
extension ProfileViewController {
    
    func showProfile(_ profile: Profile?) {
        self.profile = profile
        profileView.update(profile)
        tableView.reloadData()
    }
    
    func showProfileItems(_ profileItems: [ProfileItem]) {
        self.profileItems = profileItems
        tableView.reloadData()
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileItemCell.reusdeId, for: indexPath) as? ProfileItemCell else { return UITableViewCell() }
        let profileItem = profileItems[indexPath.row]
        cell.update(profileItem)
        return cell
    }
}

//MARK: - Event Handler
extension ProfileViewController {
    
    @objc func editBarButtonTapped() {
        presenter?.editBarButtonTapped()
    }
    
}
//MARK: - Navigation
extension ProfileViewController {
    
    func navigateToProfileEditScreen() {
        var profileEditVC = ProfileEditConfigurator().configure(profile) //ProfileEditViewController()
        
        present(profileEditVC, animated: true)
    }
}

extension ProfileViewController {
    
    func setupNavigationBar() {
        var editBarButton = UIBarButtonItem.init(image: UIImage(named: "edit"), style: .done, target: self, action: #selector(editBarButtonTapped) )
        editBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = editBarButton
    }
    
    func setupViews() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            profileView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            profileView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

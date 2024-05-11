//
//  ProfilePresenter.swift
//  FakeNFT
//
//  Created by Chalkov on 10.05.2024.
//

import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewControllerProtocol? { get set }
    
    var provider: ProfileProviderProtocol? { get set}

    //UI Event
    func viewDidLoad()
    func editBarButtonTapped()
    
    //Business Logic
    func fetchProfile()
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewControllerProtocol?
    var provider: ProfileProviderProtocol? 
}

//MARK: - Business Logic
extension ProfilePresenter {
    func fetchProfile() {
        provider?.getProfile { [weak self] profile in
            
            guard let self else { return }
            print("->", profile)
            view?.showProfile(profile)
            
            let profileItems = self.provider?.getProfileItems() ?? []
            view?.showProfileItems(profileItems)
        }
    }
}

//MARK: - Event Handler
extension ProfilePresenter {
    
    func viewDidLoad() {
        fetchProfile()
    }
    
    func editBarButtonTapped() {
        view?.navigateToProfileEditScreen()
    }
}

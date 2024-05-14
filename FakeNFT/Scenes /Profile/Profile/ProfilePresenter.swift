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

    func viewDidLoad()
    func editBarButtonTapped()
    func myNFTCellSelected()

    func fetchProfile()
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewControllerProtocol?
    var provider: ProfileProviderProtocol? 
}

//MARK: - ProfilePresenterProtocol
extension ProfilePresenter {
        
    func viewDidLoad() {
        fetchProfile()
    }
    
    func editBarButtonTapped() {
        view?.navigateToProfileEditScreen()
    }
    
    func fetchProfile() {
        provider?.getProfile { [weak self] profile in
            
            guard let self else { return }
            guard let profile else { return }
            view?.showProfile(profile)
            
            let profileItems = getProfileItems(profile)
            view?.showProfileItems(profileItems)
        }
    }
    
    func getProfileItems(_ profile: Profile) -> [ProfileItem] {
        let data = [
            ProfileItem(name: "Мои NFT (\(profile.nfts.count))"),
            ProfileItem(name: "Избранные NFT (\(profile.likes.count))"),
            ProfileItem(name: "О разработчике"),
        ]
        return data
    }
    
    func myNFTCellSelected() {
        view?.navigateToMyNFTScreen()
    }
}

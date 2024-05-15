//
//  ProfileConfigurator.swift
//  FakeNFT
//
//  Created by Chalkov on 10.05.2024.
//

import UIKit

final class ProfileConfigurator {
    
    func configure() -> ProfileViewController {
        
        let profileProvider = ProfileProvider(networkClient: DefaultNetworkClient())
        let profileVC = ProfileViewController()
        let profilePresenter = ProfilePresenter()

        profileVC.presenter = profilePresenter
        profilePresenter.view = profileVC
        profilePresenter.provider = profileProvider
        
        return profileVC
    }
}

//
//  ProfileConfigurator.swift
//  FakeNFT
//
//  Created by Chalkov on 10.05.2024.
//

import UIKit

final class ProfileConfigurator {
    
    func configure() -> ProfileViewController {
        
        var profileProvider = ProfileProvider(networkClient: DefaultNetworkClient())
        var profileVC = ProfileViewController()
        var profilePresenter = ProfilePresenter()
        
        //Connections
        profileVC.presenter = profilePresenter
        profilePresenter.view = profileVC
        profilePresenter.provider = profileProvider
        
        return profileVC
    }
}

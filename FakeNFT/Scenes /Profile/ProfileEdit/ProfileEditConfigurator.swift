//
//  ProfileEditConfigurator.swift
//  FakeNFT
//
//  Created by Chalkov on 10.05.2024.
//

import UIKit

final class ProfileEditConfigurator {
    
    func configure(_ profile: Profile?) -> ProfileEditViewController {
        
        let profileEditProvider = ProfileProvider(networkClient: DefaultNetworkClient())
        let profileEditVC = ProfileEditViewController()
        let profileEditPresenter = ProfileEditPresenter()

        profileEditVC.presenter = profileEditPresenter
        profileEditPresenter.view = profileEditVC
        profileEditPresenter.provider = profileEditProvider
    
        profileEditVC.update(profile)
        
        return profileEditVC
    }
}

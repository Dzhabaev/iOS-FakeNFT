//
//  ProfileEditConfigurator.swift
//  FakeNFT
//
//  Created by Chalkov on 10.05.2024.
//

import UIKit

final class ProfileEditConfigurator {
    
    func configure(_ profile: Profile?) -> ProfileEditViewController {
        
        var profileEditProvider = ProfileProvider(networkClient: DefaultNetworkClient())
        var profileEditVC = ProfileEditViewController()
        var profileEditPresenter = ProfileEditPresenter()
        
        //Connections
        
        profileEditVC.presenter = profileEditPresenter
        profileEditPresenter.view = profileEditVC
        
        profileEditPresenter.provider = profileEditProvider
        
        profileEditVC.update(profile)
        
        return profileEditVC
    }
}

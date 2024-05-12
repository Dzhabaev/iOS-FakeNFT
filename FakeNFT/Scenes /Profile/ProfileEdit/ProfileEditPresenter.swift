//
//  ProfileEditPresenter.swift
//  FakeNFT
//
//  Created by Chalkov on 10.05.2024.
//

import UIKit

protocol ProfileEditPresenterProtocol: AnyObject {
    var view: ProfileEditViewControllerProtocol? { get set }

    func closeButtonTapped()
    func alertSaveOkTapped(_ profile: Profile?)

    func updateProfileOnServer(_ profile: Profile?)
}

final class ProfileEditPresenter: ProfileEditPresenterProtocol {

    weak var view: ProfileEditViewControllerProtocol?
    var provider: ProfileProviderProtocol?
}

//MARK: - ProfileEditPresenterProtocol
extension ProfileEditPresenter {

    func closeButtonTapped() {
        view?.showSaveAlert()
    }
    
    func alertSaveOkTapped(_ profile: Profile?) {
        updateProfileOnServer(profile)
    }
    
    func updateProfileOnServer(_ profile: Profile?) {
        
        provider?.updateProfile(profile) { [weak self] profile in
            
            guard let self else { return }
            guard let profile else { return }

            NotificationCenter.default.post(
                name: Notification.Name("ProfileUpdatedNotification"),
                object: nil,
                userInfo: ["profile": profile])
            
            self.view?.closeProfileEditScreen()
        }
    }
}

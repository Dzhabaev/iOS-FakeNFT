//
//  ProfileEditPresenter.swift
//  FakeNFT
//
//  Created by Chalkov on 10.05.2024.
//

import UIKit

protocol ProfileEditPresenterProtocol: AnyObject {
    var view: ProfileEditViewControllerProtocol? { get set }
    //var onProfileUpdated: ((Profile?)->())? { get set }
    
    //UI Event
    func viewDidLoad()
    func closeButtonTapped()
    func alertSaveOkTapped(_ profile: Profile?)
    
    //Business Logic
    func updateProfileOnServer(_ profile: Profile?)
}

final class ProfileEditPresenter: ProfileEditPresenterProtocol {
    
    //var onProfileUpdated: ((Profile?)->())?
    
    weak var view: ProfileEditViewControllerProtocol?
    var provider: ProfileProviderProtocol?
}

//MARK: Event Handler
extension ProfileEditPresenter {
    
    func viewDidLoad() {
        
    }
    
    func closeButtonTapped() {
        
        view?.showSaveAlert()
    }
    
    func alertSaveOkTapped(_ profile: Profile?) {
        updateProfileOnServer(profile)
    }
}

//MARK: Business Logic
extension ProfileEditPresenter {
    
    func updateProfileOnServer(_ profile: Profile?) {
        
        provider?.updateProfile(profile) { [weak self] profile in
            guard let self else { return }
        
            guard let profile else { return }
            //self.onProfileUpdated?(profile)
            
            NotificationCenter.default.post(name: Notification.Name("ProfileUpdatedNotification"), object: nil, userInfo: ["profile": profile])
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.view?.closeProfileEditScreen()
                //self.dismiss(animated: true)
            }
           
            
        }
    }
}

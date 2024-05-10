//
//  ProfileEditPresenter.swift
//  FakeNFT
//
//  Created by Chalkov on 10.05.2024.
//

import UIKit

protocol ProfileEditPresenterProtocol: AnyObject {
    var view: ProfileEditViewControllerProtocol? { get set }
    
    //UI Event
    func viewDidLoad()
    func closeButtonTapped()
    func alertSaveOkTapped(_ profile: Profile?)
    
    //Business Logic
    func updateProfileOnServer(_ profile: Profile?)
}

final class ProfileEditPresenter: ProfileEditPresenterProtocol {
    
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
        
        provider?.updateProfile(profile) { [weak self] error in
            guard let self else { return }
        
            self.view?.closeProfileEditScreen()
            //self.dismiss(animated: true)
            
        }
    }
}

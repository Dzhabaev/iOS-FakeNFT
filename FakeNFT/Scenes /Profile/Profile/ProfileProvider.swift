//
//  ProfileProvider.swift
//  FakeNFT
//
//  Created by Chalkov on 07.05.2024.
//

import Foundation


protocol ProfileProviderProtocol {
    func getProfile(completion: @escaping (Profile?) -> Void)
    func updateProfile(_ profile: Profile?, completion: @escaping (Profile?) -> Void)
}

final class ProfileProvider: ProfileProviderProtocol {

    private let networkClient: DefaultNetworkClient
    
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
    
    func getProfile(completion: @escaping (Profile?) -> Void) {
        
        networkClient.send(request: ProfileRequest(), type: Profile.self) { result in

            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    completion(profile)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
        }
    }
    
    func updateProfile(_ profile: Profile?, completion: @escaping (Profile?) -> Void) {
        guard let profile else { return }
        let profileData = "name=\(profile.name)&description=\(profile.description)&website=\(profile.website)&avatar=\(profile.avatar)"
        let request = ProfileUpdateRequest(profileData)
        
        networkClient.send(request: request, type: Profile.self) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    completion(profile)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
        }
    }
}

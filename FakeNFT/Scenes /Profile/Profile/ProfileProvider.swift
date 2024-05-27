//
//  ProfileProvider.swift
//  FakeNFT
//
//  Created by Chalkov on 07.05.2024.
//

import Foundation


protocol ProfileProviderProtocol {
    func getProfile(completion: @escaping (ProfileModel?) -> Void)
    func updateProfile(_ profile: ProfileModel?, completion: @escaping (ProfileModel?) -> Void)
}

final class ProfileProvider: ProfileProviderProtocol {

    private let networkClient: DefaultNetworkClient
    
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
    
    func getProfile(completion: @escaping (ProfileModel?) -> Void) {
        
        networkClient.send(request: ProfileRequest(), type: ProfileModel.self) { result in

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
    
    func updateProfile(_ profile: ProfileModel?, completion: @escaping (ProfileModel?) -> Void) {
        guard let profile else { return }
        
        var encodedLikes = profile.likes.map { String($0) }.joined(separator: ",")
        if encodedLikes.isEmpty {
            encodedLikes = "null"
        }

        let profileData = "name=\(profile.name)&description=\(profile.description)&website=\(profile.website)&avatar=\(profile.avatar)&likes=\(encodedLikes)"
        let request = ProfileUpdateRequest(profileData)
        
        networkClient.send(request: request, type: ProfileModel.self) { result in
            
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

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
                    completion(nil)
                }
            }
        }
    }
    
    func updateProfile(_ profile: Profile?, completion: @escaping (Profile?) -> Void) {
        
        guard let profile else { return }
        
        let urlString = NetworkConstants.baseURL + "/api/v1/profile/1"
        
        guard let url = URL(string:urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        request.setValue(NetworkConstants.acceptValue, forHTTPHeaderField: NetworkConstants.acceptKey)
        request.setValue(NetworkConstants.contentTypeValue, forHTTPHeaderField: NetworkConstants.contentTypeKey)
        request.setValue(NetworkConstants.tokenValue, forHTTPHeaderField: NetworkConstants.tokenKey)
        
        let encodedName = profile.name
        let encodedAvatar = profile.avatar.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let encodedDescription = profile.description
        let encodedWebsite = profile.website.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let encodedNfts = profile.nfts.map { String($0) }.joined(separator: ",")
        var encodedLikes = profile.likes.map { String($0) }.joined(separator: ",")
        if encodedLikes.isEmpty {
            encodedLikes = "null"
        }
        let encodedId = profile.id
        
        let bodyString =  "&name=\(encodedName)&avatar=\(encodedAvatar)&description=\(encodedDescription)&website=\(encodedWebsite)&nfts=\(encodedNfts)&likes=\(encodedLikes)&id=\(encodedId)"

        guard let bodyData = bodyString.data(using: .utf8) else { return }
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print(error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                
                switch response.statusCode {
                case 200..<300:
                    break
                default: break
                }
            }
            guard let data else { return }
            do {
                let profile = try JSONDecoder().decode(Profile.self, from: data)
                DispatchQueue.main.async {
                    
                    completion(profile)
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

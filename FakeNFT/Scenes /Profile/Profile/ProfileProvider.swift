//
//  ProfileProvider.swift
//  FakeNFT
//
//  Created by Chalkov on 07.05.2024.
//

import Foundation

protocol ProfileProviderProtocol {
    
    func getProfile(completion: @escaping (Profile?) -> Void)
    
    func updateProfile(_ profile: Profile?, completion: @escaping (Error?) -> Void)
    
    func getProfileItems() -> [ProfileItem]
}

final class ProfileProvider: ProfileProviderProtocol {
    
    private var profile: Profile?
    
    private let networkClient: DefaultNetworkClient
    
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
    
    func getProfileItems() -> [ProfileItem] {
        var data = [
            ProfileItem(name: "Мои NFT (\(profile?.nfts.count ?? 0))"),
            ProfileItem(name: "Избранные NFT (\(profile?.likes.count ?? 0))"),
            ProfileItem(name: "О разработчике"),
        ]
        return data
    }
    
    func getProfile(completion: @escaping (Profile?) -> Void) {
        
        networkClient.send(request: ProfileRequest(), type: Profile.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                self.profile = profile
                DispatchQueue.main.async {
                    completion(profile)
                }
            case .failure(let error):
                print("Error fetching Profile: \(error)")
               
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        
    }
    
    func updateProfile(_ profile: Profile?, completion: @escaping (Error?) -> Void) {
        
        guard let profile else { return }
        
        let urlString = NetworkConstants.baseURL + "/api/v1/profile/1"
        
        guard let url = URL(string:urlString) else { return }
        print("->", url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        request.setValue(NetworkConstants.acceptValue, forHTTPHeaderField: NetworkConstants.acceptKey)
        request.setValue(NetworkConstants.contentTypeValue, forHTTPHeaderField: NetworkConstants.contentTypeKey)
        request.setValue(NetworkConstants.tokenValue, forHTTPHeaderField: NetworkConstants.tokenKey)
        
        do {
            let bodyParams: [String: Any] = [
                "name": profile.name,
                "description": profile.description,
                "website": profile.website,
                "likes": profile.likes
            ]
            let bodyData = try JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
            print(bodyData)
            //BODY
            request.httpBody = bodyData
        } catch {
            print(error)
        }
        
        request.debug()
        

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(data?.prettyPrintedJSONString)
            if let error = error {
                
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            if let response = response as? HTTPURLResponse {
                
                switch response.statusCode {
                case 200..<300:
                    print("Success Status: \(response.statusCode)")
                    break
                default:
                    print("Status: \(response.statusCode)")
                }
            }
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
        task.resume()
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}

fileprivate extension URLRequest {
    func debug() {
        print("\(self.httpMethod!) \(self.url!)")
        print("Headers:")
        print(self.allHTTPHeaderFields!)
        print("Body:")
        print(String(data: self.httpBody ?? Data(), encoding: .utf8)!)
    }
}


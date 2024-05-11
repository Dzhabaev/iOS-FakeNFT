//
//  ProfileRequest.swift
//  FakeNFT
//
//  Created by Chalkov on 07.05.2024.
//

import Foundation


//api/v1/profile/1
//-H "Accept: application/json"\
//"https://64858e8ba795d24810b71189.mockapi.io/api/v1/profile/1"

struct ProfileRequest: NetworkRequest {
    var endpoint: URL?
    init() {
        guard let endpoint = URL(string: "\(NetworkConstants.baseURL)/api/v1/profile/1") else { return }
        self.endpoint = endpoint
    }
}


struct ProfileUpdateRequest: NetworkRequest {
    
    var endpoint: URL?
    var dto: Encodable?
    var httpMethod: HttpMethod?
    
    init(_ profile: Profile) {
        guard let endpoint = URL(string: "\(NetworkConstants.baseURL)/api/v1/profile/1") else { return }
        self.endpoint = endpoint
        
        self.httpMethod = HttpMethod.put
        
        self.dto = profile
    }
}

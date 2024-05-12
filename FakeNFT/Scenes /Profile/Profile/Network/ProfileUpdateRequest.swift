//
//  ProfileUpdateRequest.swift
//  FakeNFT
//
//  Created by Chalkov on 12.05.2024.
//

import Foundation

struct ProfileUpdateRequest: NetworkRequest {
    
    var endpoint: URL?
    var dto: Encodable?
    var httpMethod: HttpMethod?
    
    init(_ profile: Profile?) {
        
        guard let profile else { return }
        
        guard let endpoint = URL(string: "\(NetworkConstants.baseURL)/api/v1/profile/1") else { return }
        self.endpoint = endpoint
        
        self.httpMethod = HttpMethod.put
        
        self.dto = profile
    }
}

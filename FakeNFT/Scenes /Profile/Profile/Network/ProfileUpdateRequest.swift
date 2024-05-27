//
//  ProfileUpdateRequest.swift
//  FakeNFT
//
//  Created by Chalkov on 12.05.2024.
//

import Foundation

struct ProfileUpdateRequest: NetworkRequest {
    var httpMethod: HttpMethod = .put

    var endpoint: URL?
    var dto: Encodable?
    var httpBody: String?
    
    init(_ httpBody: String) {
        guard let endpoint = URL(string: "\(NetworkConstants.baseURL)/api/v1/profile/1") else { return }
        self.endpoint = endpoint
        self.httpBody = httpBody
        
    }
}

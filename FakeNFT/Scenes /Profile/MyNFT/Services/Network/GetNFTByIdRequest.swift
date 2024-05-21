//
//  GetNFTByIdRequest.swift
//  FakeNFT
//
//  Created by Chalkov on 13.05.2024.
//

import Foundation

struct GetNftByIdRequest: NetworkRequest {
    var httpMethod: HttpMethod = .get
    
    var dto: Encodable?
    
    var httpBody: String?
    
    private let id: String
    var endpoint: URL? { URL(string: "\(NetworkConstants.baseURL)/api/v1/nft/\(id)") }
    
    init(id: String) {
        self.id = id
    }
}

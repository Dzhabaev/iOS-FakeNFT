//
//  CollectionsRequest.swift
//  FakeNFT
//
//  Created by Chingiz on 23.04.2024.
//

import Foundation

struct CollectionsRequest: NetworkRequest {
    var endpoint: URL?
    init() {
        guard let endpoint = URL(string: "\(NetworkConstants.baseURL)/api/v1/collections") else { return }
        self.endpoint = endpoint
    }
}

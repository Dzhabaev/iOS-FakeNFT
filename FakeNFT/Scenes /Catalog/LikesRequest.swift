//
//  LikesRequest.swift
//  FakeNFT
//
//  Created by Chingiz on 19.05.2024.
//

import Foundation

struct LikesRequest: NetworkRequest {
    var endpoint: URL?
    init() {
        guard let endpoint = URL(string: "https://d5dn3j2ouj72b0ejucbl.apigw.yandexcloud.net/api/v1/profile/1") else { return }
        self.endpoint = endpoint
    }
}

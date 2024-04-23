//
//  CatalogModel.swift
//  FakeNFT
//
//  Created by Chingiz on 22.04.2024.
//

import Foundation

// MARK: - CatalogModel

struct CatalogModel: Codable {
    let name: String
    let cover: String
    let nfts: [String]
    let id: String
    let description: String
    let author: String
    var count: Int {
        nfts.count
    }
}

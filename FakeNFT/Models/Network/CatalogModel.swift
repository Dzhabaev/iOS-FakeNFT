//
//  CatalogModel.swift
//  FakeNFT
//
//  Created by Сергей on 24.05.2024.
//

import Foundation

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

//
//  Item.swift
//  FakeNFT
//
//  Created by Chalkov on 13.05.2024.
//

import Foundation

struct Item: Codable, Equatable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Double
    let id: String
}



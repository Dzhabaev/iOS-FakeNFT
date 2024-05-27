//
//  PersonModel.swift
//  FakeNFT
//
//  Created by Сергей on 23.05.2024.
//

import Foundation


struct Person: Decodable, Equatable {

    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating, id: String
}

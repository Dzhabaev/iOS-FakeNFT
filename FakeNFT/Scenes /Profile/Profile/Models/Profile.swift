//
//  Profile.swift
//  FakeNFT
//
//  Created by Chalkov on 07.05.2024.
//

import Foundation

struct Profile: Codable {
    
    let id: String
    private(set) var name: String
    let avatar: String
    private(set) var description: String
    private(set) var website: String
    let nfts: [String]
    let likes: [String]
    
    mutating  func updateName(_ name: String) {
        self.name = name
    }
    
    mutating  func updateDescription(_ description: String) {
        self.description = description
    }
    
    mutating func updateWebsite(_ website: String) {
        self.website = website
    }
}

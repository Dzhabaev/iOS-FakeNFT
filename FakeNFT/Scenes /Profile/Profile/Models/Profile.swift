//
//  Profile.swift
//  FakeNFT
//
//  Created by Chalkov on 07.05.2024.
//

import Foundation

struct Profile: Codable {
    
    let id: String
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    
    func updateName(_ newName: String) -> Profile {
           .init(
               id: id,
               name: newName,
               avatar: avatar,
               description: description,
               website: website,
               nfts: nfts,
               likes: likes
           )
       }

       func updateDescription(_ newDescription: String) -> Profile {
           .init(
               id: id,
               name: name,
               avatar: avatar,
               description: newDescription,
               website: website,
               nfts: nfts,
               likes: likes
           )
       }

       func updateWebsite(_ newWebsite: String) -> Profile {
           .init(
               id: id,
               name: name,
               avatar: avatar,
               description: description,
               website: newWebsite,
               nfts: nfts,
               likes: likes
           )
       }
}

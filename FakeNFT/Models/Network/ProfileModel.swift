//
//  111.swift
//  FakeNFT
//
//  Created by Сергей on 23.05.2024.
//

import Foundation

struct ProfileModel: Codable {

    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts, likes: [String]
    let id: String
    
    func updateName(_ newName: String) -> ProfileModel {
               .init(
                name: name,
                avatar: avatar,
                description: description,
                website: website,
                nfts: nfts,
                likes: likes,
                id: id
               )
           }
    
           func updateDescription(_ newDescription: String) -> ProfileModel {
               .init(
                name: name,
                avatar: avatar,
                description: description,
                website: website,
                nfts: nfts,
                likes: likes,
                id: id
               )
           }
    
           func updateWebsite(_ newWebsite: String) -> ProfileModel {
               .init(
                name: name,
                avatar: avatar,
                description: description,
                website: website,
                nfts: nfts,
                likes: likes,
                id: id
               )
           }
    }


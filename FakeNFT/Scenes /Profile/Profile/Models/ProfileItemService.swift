//
//  ProfileItemService.swift
//  FakeNFT
//
//  Created by Chalkov on 07.05.2024.
//

import Foundation

struct ProfileItem {
    var name: String
}

struct ProfileItemsService {
    
    var my = 112
    var favorite = 11

    func fetchProfileItems() -> [ProfileItem] {
        var data = [
            ProfileItem(name: "Мои NFT (\(my))"),
            ProfileItem(name: "Избранные NFT (\(favorite))"),
            ProfileItem(name: "О разработчике"),
        ]
        
        return data
    }
}

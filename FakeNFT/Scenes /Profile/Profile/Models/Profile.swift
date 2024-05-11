//
//  Profile.swift
//  FakeNFT
//
//  Created by Chalkov on 07.05.2024.
//

import Foundation

struct Profile: Codable {
    
    var id: String
    
    var name: String
    var avatar: String
    var description: String
    var website: String
    
    var nfts: [String]
    var likes: [String]
}



//struct Profile {
//    
//    var avatar = "avatar"
//    var fullName = "Joaquin Phoenix"
//    var description = """
//        Дизайнер из Казани, люблю цифровое искусство
//        и бейглы. В моей коллекции уже 100+ NFT,
//        и еще больше - на моем сайте. Открыт
//        к коллаборациям.
//        """
//    var website = "Joaquin Phoenix.com"
//}


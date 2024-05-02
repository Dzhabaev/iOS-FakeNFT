//
//  StatisticPresenter.swift
//  FakeNFT
//
//  Created by Сергей on 23.04.2024.
//

import UIKit // позже кит уберу и оставлю Foundation. На данный момент кит здесь чтобы задействовать UIimage

protocol StatisticPresenterProtocol {
    var objects: [Person] { get set }
}

final class StatisticsPresenter: StatisticPresenterProtocol {
    
    
    var objects: [Person] = [Person(name: "Alex", image: UIImage(named: "avatar") ?? UIImage(), rating: 1, nftCount: 112, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"), Person(name: "Mads", image: UIImage(named: "avatar1") ?? UIImage(), rating: 2, nftCount: 71, description: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat"), Person(name: "Temothee", image: UIImage(named: "avatar2") ?? UIImage(), rating: 3, nftCount: 51, description: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur")]
}



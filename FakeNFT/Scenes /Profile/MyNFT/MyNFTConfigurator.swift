//
//  MyNFTConfigurator.swift
//  FakeNFT
//
//  Created by Chalkov on 13.05.2024.
//

import UIKit

final class MyNFTConfigurator {
    
    func configure() -> MyNFTViewController {
        let myNFTViewController = MyNFTViewController()
        let cartSortService = CartSortService()
        let nftNetworkService = NFTNetworkService(client: DefaultNetworkClient())
        let myNFTPresenter = MyNFTPresenter()
        myNFTPresenter.cartSortService = cartSortService
        myNFTPresenter.networkService = nftNetworkService
        myNFTViewController.presenter = myNFTPresenter
        myNFTPresenter.view = myNFTViewController
        return myNFTViewController
    }
    
}

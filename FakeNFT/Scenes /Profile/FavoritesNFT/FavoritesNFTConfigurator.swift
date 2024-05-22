//
//  FavoritesNFTConfigurator.swift
//  FakeNFT
//
//  Created by Chalkov on 19.05.2024.
//

import Foundation

final class FavoritesNFTConfigurator {
    
    func configure(delegate: FavoritesDelegate) -> FavoritesNFTViewController {
        let favoritesVC = FavoritesNFTViewController()
        let favoritesPresenter = FavoritesNFTPresenter()
        let favoritesService = FavoritesService()
        favoritesPresenter.networkService = favoritesService
        favoritesVC.presenter = favoritesPresenter
        favoritesPresenter.view = favoritesVC
        favoritesPresenter.delegate = delegate
        return favoritesVC
    }
}

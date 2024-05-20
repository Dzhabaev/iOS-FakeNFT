//
//  FavoritesNFTPresenter.swift
//  FakeNFT
//
//  Created by Chalkov on 19.05.2024.
//

import Foundation

protocol FavoritesNFTPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellForItem(at indexPath: IndexPath) -> Item
    func dislikeButtonTapped(at indexPath: IndexPath)
}

protocol FavoritesDelegate: AnyObject {
    func didDeleteItem(at id: String)
}

final class FavoritesNFTPresenter: FavoritesNFTPresenterProtocol {
    
    var view: FavoritesNFTViewControllerProtocol?
    var networkService: FavoritesServiceProtocol?
    weak var delegate: FavoritesDelegate?
    
    private lazy var nftItems: [Item] = []
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        nftItems.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> Item {
        nftItems[indexPath.item]
    }
    
    func viewDidLoad() {
        view?.showProgressHUB()
        
        networkService?.getFavorites { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nftItems):
                view?.dismissProgressHUB()
                self.nftItems = nftItems
                if nftItems.isEmpty {
                    view?.showEmptyCart()
                } else {
                    view?.updateUI()
                }
            case .failure(let error):
                view?.showAlertController(error)
            }
        }
    }
    
    func dislikeButtonTapped(at indexPath: IndexPath) {
        let deletedItem = nftItems[indexPath.item]
        delegate?.didDeleteItem(at: deletedItem.id)
        nftItems.remove(at: indexPath.item)
        if nftItems.isEmpty {
            view?.showEmptyCart()
        } else {
            view?.updateUI()
        }
    }
}

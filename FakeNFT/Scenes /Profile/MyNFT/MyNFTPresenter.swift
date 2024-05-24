//
//  MyNFTPresenter.swift
//  FakeNFT
//
//  Created by Chalkov on 13.05.2024.
//

import Foundation

protocol MyNFTPresenterProtocol: AnyObject {
    
    var view: MyNFTViewControllerProtocol? { get set }
    var networkService: NFTNetworkServiceProtocol? { get set }
    var cartSortService: CartSortServiceProtocol? { get set }
    
    func viewDidLoad()
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> MyNFTCell
    func sortButtonTapped()
}

final class MyNFTPresenter {
    
    private var alertComponent = AlertComponent()
    
    weak var view: MyNFTViewControllerProtocol?

    var networkService: NFTNetworkServiceProtocol?
    var cartSortService: CartSortServiceProtocol?
    
    private lazy var nftItems: [Item] = []
}

// MARK: - MyNFTPresenterProtocol

extension MyNFTPresenter: MyNFTPresenterProtocol {
    
    func viewDidLoad() {
        view?.showProgressHUB()
        networkService?.getMyNft { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nftItems):

                view?.dismissProgressHUB()
                self.nftItems = nftItems
                if nftItems.isEmpty {
                    view?.showEmptyCart()
                } else {
                    applySortType()
                }
            case .failure(_):
                view?.dismissProgressHUB()
            }
        }
    }
    
    private func sortByPrice() {
        nftItems.sort { $0.price > $1.price }
        view?.updateUI()
        cartSortService?.saveSortType(.byPrice)
    }
    
    private func sortByRating() {
        nftItems.sort { $0.rating > $1.rating }
        view?.updateUI()
        cartSortService?.saveSortType(.byRating)
    }
    
    private func sortByName() {
        nftItems.sort { $0.name < $1.name }
        view?.updateUI()
        cartSortService?.saveSortType(.byName)
    }
    
    private func applySortType() {
        switch cartSortService?.loadSortType() {
        case .byPrice:
            sortByPrice()
        case .byRating:
            sortByRating()
        case .byName:
            sortByName()
        default: break
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        nftItems.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> MyNFTCell {
        let cell = MyNFTCell()
        cell.update(nftItems[indexPath.row])
        return cell
    }
    
    func sortButtonTapped() {
        let sortAlertController = alertComponent.makeSortingAlert { [weak self] in
            self?.sortByPrice()
        } ratingAction: { [weak self] in
            self?.sortByRating()
        } nameAction: { [weak self] in
            self?.sortByName()
        }
        view?.navigateToSortAlert(sortAlertController)
    }
}

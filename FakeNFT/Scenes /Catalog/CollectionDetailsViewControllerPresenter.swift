//
//  CollectionDetailsViewControllerPresenter.swift
//  FakeNFT
//
//  Created by Chingiz on 08.05.2024.
//

import Foundation

// MARK: - CollectionDetailsViewControllerPresenter

final class CollectionDetailsViewControllerPresenter {
    
    typealias Completion = (Result<Nft, Error>) -> Void
    
    weak var viewController: CollectionDetailsViewController?
    let authorURLString = "https://practicum.yandex.ru/ios-developer/"
    
    // MARK: - Private Properties
    
    private var onLoadCompletion: (([Nft]) -> Void)?
    private var idLikes: Set<String> = []
    private var idAddedToCart: Set<String> = []
    private let nftModel: CatalogModel
    private let nftService: NftService
    private var loadedNFTs: [Nft] = []
    private let userNFTService: UserNFTService
    private var checkedNftIds: Set<String> = []
    private var fetchingNftLikes: Set<String> = []
    private var checkedNft: Set<String> = []
    private var fetchingNftCart: Set<String> = []
    
    // MARK: - Initializers
    
    init(nftModel: CatalogModel, nftService: NftService, userNFTService: UserNFTService) {
        self.nftModel = nftModel
        self.nftService = nftService
        self.userNFTService = userNFTService
    }
    
    // MARK: - Public Methods
    
    func returnCollectionCell(for index: Int) -> CollectionCellModel {
        let nftForIndex = loadedNFTs[index]
        checkIfNftIsFavorite(nftForIndex.id)
        checkIfNftIsAddedToCart(nftForIndex.id)
        return CollectionCellModel(image: nftForIndex.images[0],
                                   name: nftForIndex.name,
                                   rating: nftForIndex.rating,
                                   price: nftForIndex.price,
                                   isLiked: self.isLiked(nftForIndex.id),
                                   isAddedToCart: self.isAddedToCart(nftForIndex.id),
                                   id: nftForIndex.id
        )
    }
    
    func processNFTsLoading() {
        for id in nftModel.nfts {
            loadNftById(id: id)
        }
    }
    
    func setOnLoadCompletion(_ completion: @escaping ([Nft]) -> Void) {
        onLoadCompletion = completion
    }
    
    // MARK: - Private Methods
    
    private func loadNftById(id: String) {
        nftService.loadNft(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let nft):
                self.loadedNFTs.append(nft)
                self.onLoadCompletion?(self.loadedNFTs)
            case .failure(let error):
                let errorModel = self.makeErrorModel(error, option: {self.loadNftById(id: id)})
                self.viewController?.showError(errorModel)
            }
        }
    }
    
    private func isLiked(_ idOfCell: String) -> Bool {
        idLikes.contains(idOfCell)
    }
    
    private func isAddedToCart(_ idOfCell: String) -> Bool {
        idAddedToCart.contains(idOfCell)
    }
    
    private func checkIfNftIsFavorite(_ nftId: String) {
        guard !checkedNftIds.contains(nftId) else {
            return
        }
        guard !fetchingNftLikes.contains(nftId) else {
            return
        }
        fetchingNftLikes.insert(nftId)
        userNFTService.getProfile { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.fetchingNftLikes.remove(nftId)
            }
            guard !self.checkedNftIds.contains(nftId) else {
                return
            }
            self.checkedNftIds.insert(nftId)
            switch result {
            case .success(let profile):
                let newLikes = profile.likes
                let isFavorite = newLikes.contains(nftId)
                DispatchQueue.main.async {
                    self.viewController?.updateLikeButtonColor(isLiked: isFavorite, for: nftId)
                }
            case .failure(let error):
                let errorModel = self.makeErrorModel(error, option: { self.checkIfNftIsFavorite(nftId) })
                DispatchQueue.main.async {
                    self.viewController?.showError(errorModel)
                }
            }
        }
    }
    
    private func checkIfNftIsAddedToCart(_ nftId: String) {
        guard !checkedNft.contains(nftId) else {
            return
        }
        guard !fetchingNftCart.contains(nftId) else {
            return
        }
        fetchingNftCart.insert(nftId)
        userNFTService.getCart { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.fetchingNftCart.remove(nftId)
            }
            guard !self.checkedNft.contains(nftId) else {
                return
            }
            self.checkedNft.insert(nftId)
            switch result {
            case .success(let cart):
                let newCart = cart.nfts
                let isAddedToCart = newCart.contains(nftId)
                DispatchQueue.main.async {
                    if isAddedToCart {
                        self.viewController?.updateCartButtonImage(isAddedToCart: true, for: nftId)
                    }
                }
            case .failure(let error):
                let errorModel = self.makeErrorModel(error, option: { self.checkIfNftIsAddedToCart(nftId) })
                DispatchQueue.main.async {
                    self.viewController?.showError(errorModel)
                }
            }
        }
    }
}

// MARK: - CollectionDetailsNftCardCellDelegate

extension CollectionDetailsViewControllerPresenter: CollectionDetailsNftCardCellDelegate {
    
    func likeButtonTapped(for itemId: String) {
        if idLikes.contains(itemId) {
            idLikes.remove(itemId)
        } else {
            idLikes.insert(itemId)
        }
        userNFTService.getProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                let newLikes = profile.likes
                self.userNFTService.changeLike(newLikes: Array(newLikes), profile: profile) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            self.viewController?.updateLikeButtonColor(isLiked: self.isLiked(itemId), for: itemId)
                        }
                    case .failure(let error):
                        let errorModel = self.makeErrorModel(error, option: { self.likeButtonTapped(for: itemId) })
                        DispatchQueue.main.async {
                            self.viewController?.showError(errorModel)
                        }
                    }
                }
            case .failure(let error):
                let errorModel = self.makeErrorModel(error, option: { self.likeButtonTapped(for: itemId) })
                DispatchQueue.main.async {
                    self.viewController?.showError(errorModel)
                }
            }
        }
    }
    
    func cartButtonTapped(for itemId: String) {
        if idAddedToCart.contains(itemId) {
            idAddedToCart.remove(itemId)
        } else {
            idAddedToCart.insert(itemId)
        }
        userNFTService.getCart { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cart):
                self.userNFTService.changeCart(newCart: Array(cart.nfts), cart: cart) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            self.viewController?.updateCartButtonImage(isAddedToCart: self.isAddedToCart(itemId), for: itemId)
                        }
                    case .failure(let error):
                        let errorModel = self.makeErrorModel(error, option: { self.cartButtonTapped(for: itemId) })
                        DispatchQueue.main.async {
                            self.viewController?.showError(errorModel)
                        }
                    }
                }
            case .failure(let error):
                let errorModel = self.makeErrorModel(error, option: { self.cartButtonTapped(for: itemId) })
                DispatchQueue.main.async {
                    self.viewController?.showError(errorModel)
                }
            }
        }
    }
}

// MARK: - Error handling

extension CollectionDetailsViewControllerPresenter {
    private func makeErrorModel(_ error: Error, option: (()->Void)?) -> ErrorModel {
        let message: String
        switch error {
        case is NetworkClientError:
            message = "Произошла сетевая ошибка. Пожалуйста, попробуйте снова."
        default:
            message = "Произошла непредвиденная ошибка. Пожалуйста, попробуйте снова."
        }
        let actionText = "Повторить"
        return ErrorModel(message: message, actionText: actionText) {
            if let option = option {
                option()
            }
        }
    }
}

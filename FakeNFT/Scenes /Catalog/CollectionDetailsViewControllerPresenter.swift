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
    private var authorURL: String = ""
    private var idLikes: Set<String> = []
    private var idAddedToCart: Set<String> = []
    private let nftModel: CatalogModel
    private let nftService: NftService
    private var loadedNFTs: [Nft] = []
    private let likesNetwork = LikesNetwork()
    private var checkedNftIds: Set<String> = []
    private var fetchingNftLikes: Set<String> = []
    
    // MARK: - Initializers
    
    init(nftModel: CatalogModel, nftService: NftService) {
        self.nftModel = nftModel
        self.nftService = nftService
    }
    
    // MARK: - Public Methods
    
    func returnCollectionCell(for index: Int) -> CollectionCellModel {
        let nftForIndex = loadedNFTs[index]
        checkIfNftIsFavorite(nftForIndex.id)
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
    
    private func addItemToCart(_ cartNetwork: CartNetwork, _ cart: Cart, itemId: String) {
        var updatedNfts = cart.nfts
        updatedNfts.append(itemId)
        cartNetwork.sendNewOrder(nftsIds: updatedNfts) { error in
            if let error = error {
                let errorModel = self.makeErrorModel(error, option: {self.addItemToCart(cartNetwork, cart, itemId: itemId)})
                DispatchQueue.main.async {
                    self.viewController?.showError(errorModel)
                }
                return
            }
            DispatchQueue.main.async {
                self.idAddedToCart.insert(itemId)
                self.viewController?.reloadCollectionView()
            }
        }
    }
    
    private func removeItemFromCart(_ cartNetwork: CartNetwork, _ cart: Cart, itemId: String) {
        var updatedNfts = cart.nfts
        if let index = updatedNfts.firstIndex(of: itemId) {
            updatedNfts.remove(at: index)
        }
        cartNetwork.sendNewOrder(nftsIds: updatedNfts) { error in
            if let error = error {
                let errorModel = self.makeErrorModel(error, option: {self.removeItemFromCart(cartNetwork, cart, itemId: itemId)})
                DispatchQueue.main.async {
                    self.viewController?.showError(errorModel)
                }
                return
            }
            DispatchQueue.main.async {
                self.idAddedToCart.remove(itemId)
                self.viewController?.reloadCollectionView()
            }
        }
    }
    
    private func addItemToLikes(_ likesNetwork: LikesNetwork, _ likes: Likes, itemId: String) {
        var updatedLikes = likes.likes
        updatedLikes.append(itemId)
        likesNetwork.sendNewOrder(nftsIds: updatedLikes) { error in
            if let error = error {
                let errorModel = self.makeErrorModel(error, option: {self.addItemToLikes(likesNetwork, likes, itemId: itemId)})
                DispatchQueue.main.async {
                    self.viewController?.showError(errorModel)
                }
                return
            }
            DispatchQueue.main.async {
                self.idLikes.insert(itemId)
                self.viewController?.reloadCollectionView()
            }
        }
    }
    
    private func removeItemFromLikes(_ likesNetwork: LikesNetwork, _ likes: Likes, itemId: String) {
        var updatedLikes = likes.likes
        if let index = updatedLikes.firstIndex(of: itemId) {
            updatedLikes.remove(at: index)
        }
        likesNetwork.sendNewOrder(nftsIds: updatedLikes) { error in
            if let error = error {
                let errorModel = self.makeErrorModel(error, option: {self.removeItemFromLikes(likesNetwork, likes, itemId: itemId)})
                DispatchQueue.main.async {
                    self.viewController?.showError(errorModel)
                }
                return
            }
            DispatchQueue.main.async {
                self.idLikes.remove(itemId)
                self.viewController?.reloadCollectionView()
            }
        }
    }
    
    private func checkIfNftIsFavorite(_ nftId: String) {
        guard !checkedNftIds.contains(nftId) else {
            return
        }
        guard !fetchingNftLikes.contains(nftId) else {
            return
        }
        fetchingNftLikes.insert(nftId)
        likesNetwork.getLikes { [weak self] likes in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.fetchingNftLikes.remove(nftId)
            }
            guard !self.checkedNftIds.contains(nftId) else {
                return
            }
            self.checkedNftIds.insert(nftId)
            if let likes = likes {
                let isFavorite = likes.likes.contains(nftId)
                DispatchQueue.main.async {
                    self.viewController?.updateLikeButtonColor(isLiked: isFavorite, for: nftId)
                }
            }
        }
    }
}

// MARK: - CollectionDetailsNftCardCellDelegate

extension CollectionDetailsViewControllerPresenter: CollectionDetailsNftCardCellDelegate {
    
    func likeButtonTapped(for itemId: String) {
        if let index = loadedNFTs.firstIndex(where: { $0.id == itemId }) {
            let nft = loadedNFTs[index]
            likesNetwork.getLikes { [weak self] likes in
                guard let self = self, let likes = likes else { return }
                if self.isLiked(nft.id) {
                    self.removeItemFromLikes(likesNetwork, likes, itemId: nft.id)
                } else {
                    self.addItemToLikes(likesNetwork, likes, itemId: nft.id)
                }
            }
        }
    }
    
    func cartButtonTapped(for itemId: String) {
        if let index = loadedNFTs.firstIndex(where: { $0.id == itemId }) {
            let nft = loadedNFTs[index]
            let cartNetwork = CartNetwork()
            cartNetwork.getCart { [weak self] cart in
                guard let self = self, let cart = cart else { return }
                if self.isAddedToCart(nft.id) {
                    self.removeItemFromCart(cartNetwork, cart, itemId: nft.id)
                } else {
                    self.addItemToCart(cartNetwork, cart, itemId: nft.id)
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

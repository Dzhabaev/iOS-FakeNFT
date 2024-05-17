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
    
    private var onLoadCompletion: (([Nft]) -> Void)?
    private var authorURL: String = ""
    private var idLikes: Set<String> = []
    private var idAddedToCart: Set<String> = []
    private let nftModel: CatalogModel
    private let nftService: NftService
    private var loadedNFTs: [Nft] = []
    
    init(nftModel: CatalogModel, nftService: NftService) {
        self.nftModel = nftModel
        self.nftService = nftService
    }
    
    func returnCollectionCell(for index: Int) -> CollectionCellModel {
        let nftForIndex = loadedNFTs[index]
        return CollectionCellModel(image: nftForIndex.images[0],
                                   name: nftForIndex.name,
                                   rating: nftForIndex.rating,
                                   price: nftForIndex.price,
                                   isLiked: self.isLiked(nftForIndex.id),
                                   isAddedToCart: self.isAddedToCart(nftForIndex.id),
                                   id: nftForIndex.id
        )
    }
    
    func isLiked(_ idOfCell: String) -> Bool {
        idLikes.contains(idOfCell)
    }
    
    func isAddedToCart(_ idOfCell: String) -> Bool {
        idAddedToCart.contains(idOfCell)
    }
    
    func processNFTsLoading() {
        for id in nftModel.nfts {
            loadNftById(id: id)
        }
    }
    
    private func loadNftById(id: String) {
        nftService.loadNft(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let nft):
                self.loadedNFTs.append(nft)
                self.onLoadCompletion?(self.loadedNFTs)
            case .failure(let error):
                let errorModel = self.makeErrorModel(error, option: {self.loadNftById(id: id)})
                viewController?.showError(errorModel)
            }
        }
    }
    
    func setOnLoadCompletion(_ completion: @escaping ([Nft]) -> Void) {
        onLoadCompletion = completion
    }
}

//MARK: - Error handling

extension CollectionDetailsViewControllerPresenter {
    private func makeErrorModel(_ error: Error, option: (()->Void)?) -> ErrorModel {
        let message: String
        switch error {
        case is NetworkClientError:
            message = "Произошла ошибка сети"
        default:
            message = "Произошла неизвестная ошибка"
        }
        let actionText = "Повторить"
        return ErrorModel(message: message, actionText: actionText) {
            if let option {
                option()
            }
        }
    }
}

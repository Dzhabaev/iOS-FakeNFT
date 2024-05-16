//
//  CollectionDetailsViewControllerPresenter.swift
//  FakeNFT
//
//  Created by Chingiz on 08.05.2024.
//

import Foundation
import SafariServices


// MARK: - CollectionDetailsViewControllerProtocol

protocol CollectionDetailsViewControllerProtocol {
    func authorLinkTapped()
}

// MARK: - CollectionDetailsViewControllerPresenter

final class CollectionDetailsViewControllerPresenter {
    
    typealias Completion = (Result<Nft, Error>) -> Void
    
    weak var viewController: CollectionDetailsViewController?
    var nftArray: [Nft] = []
    
    private var onLoadCompletion: (() -> Void)?
    private var authorURL: String = ""
    private var idLikes: Set<String> = []
    private var idAddedToCart: Set<String> = []
    private let nftModel: CatalogModel
    private let nftService: NftService
    
    init(nftModel: CatalogModel, nftService: NftService) {
        self.nftModel = nftModel
        self.nftService = nftService
    }
    
    func authorLinkTapped() {
        if let collectionCoverURLString = viewController?.collection?.cover, let url = URL(string: collectionCoverURLString) {
            let safariViewController = SFSafariViewController(url: url)
            viewController?.present(safariViewController, animated: true)
        }
    }
    
    func returnCollectionCell(for index: Int) -> CollectionCellModel {
        let nftForIndex = nftArray[index]
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
                self.nftArray.append(nft)
                self.onLoadCompletion?()
            case .failure(let error):
                print("Failed to load NFT with id: \(id), error: \(error)")
            }
        }
    }
    
    func setOnLoadCompletion(_ completion: @escaping () -> Void) {
        onLoadCompletion = completion
    }
}

//
//  CatalogProvider.swift
//  FakeNFT
//
//  Created by Chingiz on 23.04.2024.
//

import Foundation

// MARK: - CatalogProvider

protocol CatalogProvider {
    func getCollection(completion: @escaping ([CatalogModel]) -> Void)
}

// MARK: - CatalogProviderImpl

final class CatalogProviderImpl: CatalogProvider {
    
    private var collections: [CatalogModel] = []
    private let networkClient: DefaultNetworkClient
    
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCollection(completion: @escaping ([CatalogModel]) -> Void) {
        networkClient.send(request: CollectionsRequest(), type: [CatalogModel].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let nft):
                self.collections = nft
                completion(nft)
            case .failure(let error):
                print("Error fetching NFT collection: \(error)")
                completion([])
            }
        }
    }
}

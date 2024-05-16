//
//  NFTNetworkService.swift
//  FakeNFT
//
//  Created by Chalkov on 13.05.2024.
//

import Foundation

protocol NFTNetworkServiceProtocol {
    func getMyNft(_ completion: @escaping (Result<[Item], Error>) -> Void)
}

final class NFTNetworkService  {
    
    private let client: NetworkClient
    
    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }
    
    private func handleResult<T>(_ result: Result<T, Error>, completion: @escaping (Result<T, Error>) -> Void) {
        
        DispatchQueue.main.async {
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    private func fetchNftsIdInMyNFT(_ completion: @escaping (Result<Order, Error>) -> Void) {
        
        let request = ProfileRequest()
        client.send(request: request, type: Order.self) { [weak self] result in
            
            self?.handleResult(result, completion: completion)
        }
    }
    
    private func fetchMyNFT(nftsInCart: Order, _ completion: @escaping (Result<[Item], Error>) -> Void) {
        
        var nftItems: [Item] = []
        let group = DispatchGroup()
        
        let nfts: [String] = nftsInCart.nfts

        for item in nfts {
            group.enter()
            
            client.send(request: GetNftByIdRequest(id: item), type: Item.self) { result in
                switch result {
                case .success(let nftItem):
                    nftItems.append(nftItem)
                    group.leave()
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(.success(nftItems))
        }
    }
}

//MARK: - NFTNetworkServiceProtocol
extension NFTNetworkService: NFTNetworkServiceProtocol {
    
    func getMyNft(_ completion: @escaping (Result<[Item], Error>) -> Void) {
        
        fetchNftsIdInMyNFT { [weak self] result in
            switch result {
            case .success(let nftsInCart):
                
                self?.fetchMyNFT(nftsInCart: nftsInCart) { [weak self] result in
                    self?.handleResult(result, completion: completion)
                }
            case .failure(let error):
                self?.handleResult(.failure(error), completion: completion)
            }
        }
    }
    
}

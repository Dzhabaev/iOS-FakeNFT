//
//  FavoritesService.swift
//  FakeNFT
//
//  Created by Chalkov on 19.05.2024.
//

import Foundation

struct Favorites: Codable {
    let likes: [String]
}

protocol FavoritesServiceProtocol {
    func getFavorites(_ completion: @escaping (Result<[Item], Error>) -> Void)
}

final class FavoritesService: FavoritesServiceProtocol{

    private let client: NetworkClient

    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }
    
    //MARK: - Public
    func getFavorites(_ completion: @escaping (Result<[Item], Error>) -> Void) {
        getFavorites { [weak self] result in
            switch result {
            case .success(let nftsInCart):
                self?.fetchFavorites(nftsInCart: nftsInCart) { [weak self] result in
                    self?.handleResult(result, completion: completion)
                }
            case .failure(let error):
                self?.handleResult(.failure(error), completion: completion)
            }
        }
    }
    
    //MARK: - Private
    
    private func getFavorites(_ completion: @escaping (Result<Favorites, Error>) -> Void) {
        let request = ProfileRequest()
        client.send(request: request, type: Favorites.self) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
    
    private func fetchFavorites(nftsInCart: Favorites, _ completion: @escaping (Result<[Item], Error>) -> Void) {
        var nftItems: [Item] = []
        let group = DispatchGroup()
        nftsInCart.likes.forEach {
            group.enter()
            client.send(request: GetNftByIdRequest(id: $0), type: Item.self) { result in
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
    
    private func handleResult<T>(_ result: Result<T, Error>, completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
        case .success(let success):
            DispatchQueue.main.async {
                completion(.success(success))
            }
        case .failure(let failure):
            DispatchQueue.main.async {
                completion(.failure(failure))
            }
        }
    }
}

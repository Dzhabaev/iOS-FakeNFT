//
//  CatalogPresenter.swift
//  FakeNFT
//
//  Created by Chingiz on 25.04.2024.
//

import Foundation

// MARK: - SortTypeCatalog

enum SortTypeCatalog {
    case none
    case byName
    case byQuantity
}

// MARK: - CatalogPresenter

final class CatalogPresenter {
    
    // MARK: - Private Properties
    
    private let catalogProvider: CatalogProvider = CatalogProviderImpl(networkClient: DefaultNetworkClient())
    private var catalogItems: [CatalogModel] = []
    private var sortType: SortTypeCatalog = .none
    
    // MARK: - Public Methods
    
    func fetchCollectionAndUpdate(completion: @escaping ([CatalogModel]) -> Void) {
        catalogProvider.getCollection { [weak self] catalogItems in
            guard let self = self else { return }
            self.setCatalogItems(catalogItems)
            completion(catalogItems)
        }
    }
    
    func sortCatalog(by sortType: SortTypeCatalog) -> [CatalogModel] {
        switch sortType {
        case .none:
            return catalogItems
        case .byName:
            return catalogItems.sorted { $0.name < $1.name }
        case .byQuantity:
            return catalogItems.sorted { $0.count > $1.count }
        }
    }
    
    // MARK: - Private Methods
    
    private func setCatalogItems(_ items: [CatalogModel]) {
        catalogItems = items
    }
}

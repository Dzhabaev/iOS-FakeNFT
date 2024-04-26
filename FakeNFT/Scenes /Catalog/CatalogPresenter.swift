//
//  CatalogPresenter.swift
//  FakeNFT
//
//  Created by Chingiz on 25.04.2024.
//

import Foundation
import ProgressHUD

// MARK: - SortType

enum SortType {
    case none
    case byName
    case byQuantity
}

// MARK: - CatalogPresenter

final class CatalogPresenter {
    
    // MARK: - Private Properties
    
    private let catalogProvider: CatalogProvider = CatalogProviderImpl(networkClient: DefaultNetworkClient())
    private var catalogItems: [CatalogModel] = []
    private var sortType: SortType = .none
    
    // MARK: - Public Methods
    
    func fetchCollectionAndUpdate(completion: @escaping ([CatalogModel]) -> Void) {
        ProgressHUD.show()
        catalogProvider.getCollection { [weak self] catalogItems in
            self?.setCatalogItems(catalogItems)
            DispatchQueue.main.async {
                ProgressHUD.dismiss()
                completion(catalogItems)
            }
        }
    }
    
    func sortCatalog(by sortType: SortType) -> [CatalogModel] {
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

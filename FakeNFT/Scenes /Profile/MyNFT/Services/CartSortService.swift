//
//  CartSortService.swift
//  FakeNFT
//
//  Created by Chalkov on 13.05.2024.
//

import Foundation

enum CartSortType: Int {
    case byName
    case byPrice
    case byRating
}

protocol CartSortServiceProtocol {
    func saveSortType(_ type: CartSortType)
    func loadSortType() -> CartSortType
}

final class CartSortService: CartSortServiceProtocol {
    
    private let key = String(describing: CartSortService.self)
    
    func saveSortType(_ type: CartSortType) {
        UserDefaults.standard.set(type.rawValue, forKey: key)
    }
    
    func loadSortType() -> CartSortType {
        CartSortType(rawValue: UserDefaults.standard.integer(forKey: key)) ?? .byName
    }
}

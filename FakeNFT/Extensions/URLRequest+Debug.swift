//
//  URLRequest+Debug.swift
//  FakeNFT
//
//  Created by Chalkov on 12.05.2024.
//

import Foundation

extension URLRequest {
    func debug() {
        print("\(self.httpMethod!) \(self.url!)")
        print("Headers:")
        print(self.allHTTPHeaderFields!)
        print("Body:")
        print(String(data: self.httpBody ?? Data(), encoding: .utf8)!)
    }
}

//
//  ImageLoader.swift
//  FakeNFT
//
//  Created by Chingiz on 23.04.2024.
//

import UIKit

// MARK: - ImageLoader

final class ImageLoader {
    
    static let shared = ImageLoader()
    private init() {}
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}

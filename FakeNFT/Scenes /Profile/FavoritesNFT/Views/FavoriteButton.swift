//
//  FavoriteButton.swift
//  FakeNFT
//
//  Created by Chalkov on 19.05.2024.
//

import UIKit

final class FavoriteButton: UIButton {

    var nftID: String?
    
    var isFavorite: Bool = true {
        didSet {
            if isFavorite {
                setImage(UIImage(named: "like-on"), for: .normal)
            } else {
                setImage(UIImage(named: "like-off"), for: .normal)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

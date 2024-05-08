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
    
    weak var viewController: CollectionDetailsViewController?
    var authorURL: String = ""
    
    func authorLinkTapped() {
        if let collectionCoverURLString = viewController?.collection?.cover, let url = URL(string: collectionCoverURLString) {
            let safariViewController = SFSafariViewController(url: url)
            viewController?.present(safariViewController, animated: true)
        }
    }
}

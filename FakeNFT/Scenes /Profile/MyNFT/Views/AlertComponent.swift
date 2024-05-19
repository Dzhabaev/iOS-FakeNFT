//
//  AlertComponent.swift
//  FakeNFT
//
//  Created by Chalkov on 13.05.2024.
//

import UIKit

final class AlertComponent {
    
    func makeSortingAlert(
        priceAction: @escaping () -> Void,
        ratingAction: @escaping () -> Void,
        nameAction: @escaping () -> Void
    ) -> UIAlertController {
        
        let sortAlert = UIAlertController(
            title: "Сортировка",
            message: nil,
            preferredStyle: .actionSheet
        )
        let atPriceAction = UIAlertAction(
            title: "По цене",
            style: .default
        ) { _ in
            priceAction()
        }
        let atRatingAction = UIAlertAction(
            title: "По рейтингу",
            style: .default
        ) { _ in
            ratingAction()
        }
        let atNameAction = UIAlertAction(
            title: "По названию",
            style: .default
        ) { _ in
            nameAction()
        }
        let closeAction = UIAlertAction(
            title: "Закрыть",
            style: .cancel
        )
        
        [atPriceAction, atRatingAction, atNameAction, closeAction].forEach {
            sortAlert.addAction($0)
        }
        return sortAlert
    }
}

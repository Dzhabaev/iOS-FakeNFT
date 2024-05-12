//
//  TextField.swift
//  FakeNFT
//
//  Created by Chalkov on 12.05.2024.
//

import UIKit

final class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

//
//  UIButton+Extension.swift
//
//
//  Created by Arda Ersoy on 16.12.2023.
//

import Foundation
import UIKit

public extension UIButton {

    @IBInspectable
    var padding: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            imageEdgeInsets = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: newValue / .two)
            titleEdgeInsets = UIEdgeInsets(top: .zero, left: newValue / .two, bottom: .zero, right: .zero)
        }
    }
}

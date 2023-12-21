//
//  UITextView+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import UIKit

public extension UITextView {

    enum LabelSize: Int {
        case extraSmall = 10
        case small = 12
        case medium = 16
        case large = 24
        case extraLarge = 36
    }

    func configure(text: String,
                   textColor: UIColor,
                   font: UIFont,
                   fontSize: LabelSize = .medium) {
        self.text = text
        self.font = font.withSize(fontSize.rawValue.cgFloatValue)
        self.textColor = textColor
    }
}

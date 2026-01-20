//
//  UILabel+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import UIKit

public extension UILabel {
    
    enum LabelSize: Int {
        case extraSmall = 10
        case small = 12
        case medium = 16
        case large = 24
        case extraLarge = 36
    }
    
    func configure(text: String,
                   textColor: UIColor,
                   isAttributedString: Bool? = nil,
                   font: UIFont? = nil,
                   size: CGFloat = 16.0) {
        self.font = font?.withSize(size)
        self.textColor = textColor
        
        if isAttributedString ?? false {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = .five
            
            let attributedString = NSMutableAttributedString(string: text)
            let range = NSRange(location: .zero, length: attributedString.length)
            
            attributedString.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: range
            )
            
            self.attributedText = attributedString
        } else {
            self.text = text
        }
    }
}

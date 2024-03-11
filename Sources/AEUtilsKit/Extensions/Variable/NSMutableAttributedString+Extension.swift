//
//  NSMutableAttributedString+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import UIKit

public extension NSMutableAttributedString {
    
    func bold(_ value: String, font: UIFont? = nil) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font ?? .systemFont(ofSize: 14, weight: .semibold)
        ]

        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    func normal(_ value: String, font: UIFont? = nil) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font ?? .systemFont(ofSize: 14)
        ]

        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    func underlined(_ value: String, font: UIFont? = nil) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font ?? .systemFont(ofSize: 14),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func paragraph(_ value: String) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = .five
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]
        
        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}

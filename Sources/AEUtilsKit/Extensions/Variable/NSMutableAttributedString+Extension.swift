//
//  NSMutableAttributedString+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import UIKit

public extension NSMutableAttributedString {
    
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

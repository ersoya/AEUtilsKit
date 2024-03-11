//
//  UIColor+Extension.swift
//
//
//  Created by Arda Ersoy on 13.02.2024.
//

import UIKit

public extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = .one) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }
        
        var rgbValue: UInt64 = .zero
        Scanner(string: hexValue).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func randomColor() -> UIColor {
        .init(red: .random(), green: .random(), blue: .random(), alpha: .one)
    }
    
    static func generateRandomColors(upTo count: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in .zero ..< count {
            colors.append(.randomColor())
        }
        return colors
    }
}

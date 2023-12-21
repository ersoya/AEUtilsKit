//
//  UIImage+Extension.swift
//
//
//  Created by Arda Ersoy on 16.12.2023.
//

import Foundation
import UIKit

public extension UIImage {

    var data: Data {
        jpegData(compressionQuality: .zeroPointFive)!
    }

    func withColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        let drawRect = CGRect(x: .zero, y: .zero, width: size.width, height: size.height)
        color.setFill()
        UIRectFill(drawRect)

        draw(in: drawRect, blendMode: .destinationIn, alpha: .one)

        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }

    func resized(to size: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

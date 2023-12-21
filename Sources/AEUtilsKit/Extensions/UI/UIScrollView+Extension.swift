//
//  UIScrollView+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import UIKit

public extension UIScrollView {

    func scrollTo(horizontalPage: Int? = .zero, verticalPage: Int? = .zero) {
        var frame: CGRect = frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? .zero)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? .zero)
        scrollRectToVisible(frame, animated: true)
    }
}

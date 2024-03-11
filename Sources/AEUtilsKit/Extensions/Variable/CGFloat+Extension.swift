//
//  CGFloat+Extension.swift
//
//
//  Created by Arda Ersoy on 12.03.2024.
//

import Foundation

public extension CGFloat {

    static func random() -> CGFloat {
        CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

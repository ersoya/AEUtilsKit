//
//  Int+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation

public extension Int {

    var stringValue: String {
        String(self)
    }

    var cgFloatValue: CGFloat {
        CGFloat(self)
    }

    var doubleValue: Double {
        Double(self)
    }

    var indexPath: IndexPath {
        .init(row: self, section: .zero)
    }
}

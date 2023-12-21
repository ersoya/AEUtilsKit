//
//  Collection+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation

public extension Collection {

    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

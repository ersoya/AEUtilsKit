//
//  NSCollectionLayoutSize+Extension.swift
//
//
//  Created by Arda Ersoy on 14.08.2024.
//

import Foundation
import UIKit

public extension NSCollectionLayoutSize {
    
    static var absoluteZero: NSCollectionLayoutSize = .init(
        widthDimension: .absolute(.zero),
        heightDimension: .absolute(.zero)
    )
    
    static var fractionalOneEstimatedFifty: NSCollectionLayoutSize = .init(
        widthDimension: .fractionalWidth(.one),
        heightDimension: .estimated(.fifty)
    )
    
    static var estimatedFiftyAbsoluteFifty: NSCollectionLayoutSize = .init(
        widthDimension: .estimated(.fifty),
        heightDimension: .absolute(.fifty)
    )
    
    static func absoluteValue(_ value: CGFloat) -> NSCollectionLayoutSize {
        .init(
            widthDimension: .absolute(.screenWidth / .two - value),
            heightDimension: .absolute(.screenWidth / .two - value)
        )
    }
    
    static func estimatedFiftyAbsoluteValue(_ value: CGFloat) -> NSCollectionLayoutSize {
        .init(
            widthDimension: .estimated(.fifty),
            heightDimension: .absolute(value)
        )
    }
    
    static func absoluteValueEstimatedValue(_ absoluteValue: CGFloat, estimatedValue: CGFloat) -> NSCollectionLayoutSize {
        .init(
            widthDimension: .absolute(.screenWidth / .two - absoluteValue),
            heightDimension: .estimated(estimatedValue)
        )
    }
    
    static func fractionalOneEstimatedValue(_ value: CGFloat) -> NSCollectionLayoutSize {
        .init(
            widthDimension: .fractionalWidth(.one),
            heightDimension: .estimated(value)
        )
    }
}

//
//  NSDirectionalEdgeInsets+Extension.swift
//
//
//  Created by Arda Ersoy on 14.08.2024.
//

import UIKit

public extension NSDirectionalEdgeInsets {
    
    static func leadingTrailingInsets(_ value: CGFloat) -> NSDirectionalEdgeInsets  {
        .init(
            top: .zero,
            leading: value,
            bottom: .zero,
            trailing: value
        )
    }
    
    static func edgeInsets(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        .init(
            top: value,
            leading: value,
            bottom: value,
            trailing: value
        )
    }
    
    static func leadingTrailingBottomInsets(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        .init(
            top: .zero,
            leading: value,
            bottom: value,
            trailing: value
        )
    }
}

//
//  DispatchQueue+Extension.swift
//
//
//  Created by Arda Ersoy on 12.03.2024.
//

import Foundation

public extension DispatchQueue {

    static func delay(seconds: Int = 3, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds), execute: closure)
    }
}

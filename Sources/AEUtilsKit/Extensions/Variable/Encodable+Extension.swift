//
//  Encodable+Extension.swift
//
//
//  Created by Arda Ersoy on 12.03.2024.
//

import Foundation

public extension Encodable {

    var dictionary: [String: Any]? {
        let data = try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))
        return data as? [String: Any]
    }
}

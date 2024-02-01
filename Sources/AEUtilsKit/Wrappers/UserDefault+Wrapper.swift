//
//  UserDefault+Wrapper.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation

@propertyWrapper
public struct UserDefault<Value> {
    
    private let key: String
    private let defaultValue: Value
    
    private var container: UserDefaults = .standard
    
    public init(key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

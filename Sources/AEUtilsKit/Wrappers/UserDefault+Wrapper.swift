//
//  UserDefault+Wrapper.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation

@propertyWrapper
public struct UserDefault<Value: Codable> {
    
    private let key: String
    private let defaultValue: Value
    
    private var container: UserDefaults = .standard
    private let encoder: JSONEncoder = .init()
    private let decoder: JSONDecoder = .init()
    
    public init(key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: Value {
        get {
            guard
                let data = container.object(forKey: key) as? Data,
                let model = try? decoder.decode(Value.self, from: data)
            else {
                return defaultValue
            }
            
            return model
        }
        set {
            guard let model = try? encoder.encode(newValue) else { return }
            container.set(model, forKey: key)
        }
    }
}

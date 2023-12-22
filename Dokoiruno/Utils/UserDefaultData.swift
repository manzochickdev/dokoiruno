//
//  UserDefaultData.swift
//  Dokoiruno
//
//  Created by ECO0836_ANHPT on 22/12/2023.
//

import Foundation

@propertyWrapper
struct Storage<T: Codable> {
    private let key: UserDataKey
    private let defaultValue: T
    
    init(key: UserDataKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key.rawValue)
        }
    }
}

enum UserDataKey: String {
    case Event = "event_entity"
}

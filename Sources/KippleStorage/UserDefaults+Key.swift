// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension UserDefaults {
    /// A wrapper around a `String` that allows strongly typed `UserDefaults` keys with an extensible `enum`-like syntax.
    /// This value can then be extended by consumers that wish to fetch values out of `UserDefaults`. 
    ///
    /// Example:
    ///
    /// ```swift
    /// public extension UserDefaults.Key {
    ///     static let username: Self = "username"
    /// }
    /// ```
    struct Key: RawRepresentable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

// MARK: - Convenience

public extension UserDefaults {
    static let codableStore = UserDefaults(suiteName: "com.kipple.codablestore")!
}

// MARK: - Extensions

extension UserDefaults.Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(rawValue: value)
    }
}

public extension UserDefaults {
    /// Returns a `Codable` value for a given key.
    /// - Parameters:
    ///   - key: The key associated with the desired value.
    /// - Returns: The value for the given key or `nil` if the key does not exist within the store.
    func codable<Value>(forKey key: UserDefaults.Key) throws -> Value? where Value: Codable {
        try self.codable(forKey: key.rawValue)
    }

    /// Returns a `Codable` value for a given key.
    /// - Parameters:
    ///   - key: The key associated with the desired value.
    ///   - defaultValue: The default value to return of the key does not exist within the store.
    /// - Returns: The value for the given key or `defaultValue` if the key does not exist within the store.
    func codable<Value>(forKey key: UserDefaults.Key, defaultValue: Value) -> Value where Value: Codable {
        self.codable(forKey: key.rawValue, defaultValue: defaultValue)
    }

    /// Sets a `Codable` value for a given key.
    /// - Parameters:
    ///   - codableValue: The `Codable` value to save in the store.
    ///   - key: The key to associate wit the provided value.
    func set<Value>(codableValue value: Value, forKey key: Key, encoder: JSONEncoder = .userDefaults) throws where Value: Codable {
        try self.set(codableValue: value, forKey: key.rawValue, encoder: encoder)
    }

    /// Removes a value for a given key.
    /// - Parameters:
    ///   - key: The key to remove from the store.
    func removeObject(forKey key: Key) {
        self.removeObject(forKey: key.rawValue)
    }
}

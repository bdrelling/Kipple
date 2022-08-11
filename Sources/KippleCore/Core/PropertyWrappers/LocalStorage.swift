// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

// TODO: Explore rewriting this with a CurrentValueSubject in mind, and debounce the saving (and maybe fetching?)
@propertyWrapper
public struct LocalStorage<Value: Codable> {
    private let key: String
    private let defaultValue: Value

    private let userDefaults: UserDefaults = .standard

    public var wrappedValue: Value {
        didSet {
            self.storedValue = self.wrappedValue
        }
    }

    public var storedValue: Value {
        get {
            Self.fetch(key: self.key, defaultValue: self.defaultValue)
        }
        set {
            Self.store(key: self.key, newValue: newValue)
        }
    }

    public init<Key>(_ key: Key.Type) where Key: LocalStorageKey, Key.Value == Value {
        self.key = Key.name
        self.defaultValue = Key.defaultValue

        self.wrappedValue = Self.fetch(key: Key.name, defaultValue: Key.defaultValue)
    }

    public init<Key>(_ key: Key) where Key: LocalStorageKey, Key.Value == Value {
        self.init(Key.self)
    }

    public init<Key>(_ keyPath: KeyPath<LocalStorageKeys, Key>) where Key: LocalStorageKey, Key.Value == Value {
        self.init(Key.self)
    }

    public mutating func resetToDefault() {
        self.wrappedValue = self.defaultValue
    }

    public func clear() {
        Self.remove(key: self.key)
    }

    private static func fetch<Value>(key: String, defaultValue: Value, userDefaults: UserDefaults = .standard) -> Value where Value: Decodable {
        // Read value from UserDefaults.
        guard let data = userDefaults.object(forKey: key) as? Data else {
            // Return defaultValue when no data in UserDefaults.
            return defaultValue
        }

        // Convert data to the desire data type.
        let value = try? JSONDecoder().decode(Value.self, from: data)

        return value ?? defaultValue
    }

    private static func store<Value>(key: String, newValue: Value, userDefaults: UserDefaults = .standard) where Value: Encodable {
        // TODO: Add option for comparing newValue to defaultValue and clear the key if it matches.

        // Convert newValue to data.
        let data = try? JSONEncoder().encode(newValue)

        // Set value to UserDefaults.
        userDefaults.set(data, forKey: key)
    }

    private static func remove(key: String, userDefaults: UserDefaults = .standard) {
        userDefaults.removeObject(forKey: key)
    }
}

// MARK: - Supporting Types

public protocol LocalStorageKey {
    associatedtype Value
    static var name: String { get }
    static var defaultValue: Self.Value { get }
}

public struct LocalStorageKeys {}

// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

// TODO: Explore rewriting this with a CurrentValueSubject in mind, and debounce the saving (and maybe fetching?)
@propertyWrapper
public struct LocalStorage<Value> where Value: Codable, Value: Equatable {
    private let key: String
    private let defaultValue: Value

    /// Dictates whether or not the key should be removed from `UserDefaults` if the new value matches the default value.
    private let shouldClearOnDefault: Bool

    private let userDefaults: UserDefaults = .standard
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()

    public var wrappedValue: Value {
        willSet {
            self.previousValue = self.wrappedValue
        }
        didSet {
            self.storedValue = self.wrappedValue
        }
    }

    public var storedValue: Value {
        get {
            self.fetch(key: self.key, defaultValue: self.defaultValue)
        }
        set {
            self.store(key: self.key, newValue: newValue)
        }
    }

    private var previousValue: Value?

    public init<Key>(_ key: Key.Type, clearOnDefault: Bool = false) where Key: LocalStorageKey, Key.Value == Value {
        self.key = Key.name
        self.defaultValue = Key.defaultValue
        self.shouldClearOnDefault = clearOnDefault

        // Temporarily set the wrapped value to the default value
        self.wrappedValue = Key.defaultValue
        self.wrappedValue = self.fetch(key: Key.name, defaultValue: Key.defaultValue)
    }

    public init<Key>(_ key: Key, clearOnDefault: Bool = false) where Key: LocalStorageKey, Key.Value == Value {
        self.init(Key.self, clearOnDefault: clearOnDefault)
    }

    public init<Key>(_ keyPath: KeyPath<LocalStorageKeys, Key>, clearOnDefault: Bool = false) where Key: LocalStorageKey, Key.Value == Value {
        self.init(Key.self, clearOnDefault: clearOnDefault)
    }

    public mutating func resetToDefault() {
        self.wrappedValue = self.defaultValue
    }

    public func clear() {
        Self.remove(key: self.key)
    }

    private func fetch(key: String, defaultValue: Value, userDefaults: UserDefaults = .standard) -> Value {
        do {
            // Read value from UserDefaults.
            guard let data = userDefaults.object(forKey: key) as? Data else {
                // Return defaultValue when no data is in UserDefaults.
                return defaultValue
            }

            // Convert data to the desire data type.
            let value = try self.jsonDecoder.decode(Value.self, from: data)

            return value
        } catch {
            return defaultValue
        }
    }

    private func store(key: String, newValue: Value, userDefaults: UserDefaults = .standard) {
        do {
            // Only continues if the new value does not match the previous value.
            guard newValue != self.previousValue else {
                return
            }

            // If the shouldClearOnDefault setting is enabled, evaluate the new value to the default value.
            // If they match, remove the object from UserDefaults entirely, since the default value may not need to be stored.
            if self.shouldClearOnDefault, newValue == self.defaultValue {
                userDefaults.removeObject(forKey: key)
            } else {
                // Convert newValue to data.
                let data = try self.jsonEncoder.encode(newValue)

                // Set value to UserDefaults.
                userDefaults.set(data, forKey: key)
            }
        } catch {
            // do nothing
        }
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

// MARK: - Extensions

extension LocalStorage: CustomStringConvertible {
    public var description: String {
        String(describing: self.wrappedValue)
    }
}

// TODO: Add convenence initializers for AppStorage?

// #if canImport(SwiftUI)
//
// import SwiftUI
//
// @available(iOS 14.0, *)
// extension AppStorage {
//    public init<Key>(_ key: Key, store: UserDefaults? = nil) where Key: LocalStorageKey, Value == Bool? {
//        self.init(Key.name, store: store)
//    }
// }
//
// #endif

// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct LocalStore {
    public let store: UserDefaults
    public let jsonEncoder: JSONEncoder
    public let jsonDecoder: JSONDecoder

    public init(store: UserDefaults = .standard, encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) {
        self.store = store
        self.jsonEncoder = encoder
        self.jsonDecoder = decoder
    }

    public func value<Value>(forKey key: String) throws -> Value? where Value: Codable {
        // Read value from the store as raw data.
        guard let data = self.store.object(forKey: key) as? Data else {
            // Return defaultValue if there is no data found in the store.
            return nil
        }

        // Convert data to the desired data type.
        let value = try self.jsonDecoder.decode(Value.self, from: data)

        return value
    }

    public func value<Value>(forKey key: String, defaultValue: Value) -> Value where Value: Codable {
        (try? self.value(forKey: key)) ?? defaultValue
    }

    public func set<Value>(key: String, newValue: Value) throws where Value: Codable {
        // Convert the new value into data for storage.
        let data = try self.jsonEncoder.encode(newValue)

        // Save the data to the store.
        self.store.set(data, forKey: key)
    }

    public func remove(key: String) {
        self.store.removeObject(forKey: key)
    }

    public func removeAll() {
        self.store.clearAllKeys()
    }
}

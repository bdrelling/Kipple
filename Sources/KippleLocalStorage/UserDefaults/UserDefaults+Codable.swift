// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension UserDefaults {
    /// Returns a `Codable` value for a given key.
    /// - Parameters:
    ///   - key: The key associated with the desired value.
    /// - Returns: The value for the given key or `nil` if the key does not exist within the store.
    func codable<Value>(forKey key: String, decoder: JSONDecoder = .userDefaults) throws -> Value? where Value: Codable {
        // Read value from the store as raw data.
        guard let data = self.object(forKey: key) as? Data else {
            // Return defaultValue if there is no data found in the store.
            return nil
        }

        // Convert data to the desired data type.
        let value = try decoder.decode(Value.self, from: data)

        return value
    }

    /// Returns a `Codable` value for a given key.
    /// - Parameters:
    ///   - key: The key associated with the desired value.
    ///   - defaultValue: The default value to return of the key does not exist within the store.
    /// - Returns: The value for the given key or `defaultValue` if the key does not exist within the store.
    func codable<Value>(forKey key: String, defaultValue: Value, decoder: JSONDecoder = .userDefaults) -> Value where Value: Codable {
        (try? self.codable(forKey: key, decoder: decoder)) ?? defaultValue
    }

    /// Sets a `Codable` value for a given key.
    /// - Parameters:
    ///   - codableValue: The `Codable` value to save in the store.
    ///   - key: The key to associate wit the provided value.
    func set<Value>(codableValue value: Value, forKey key: String, encoder: JSONEncoder = .userDefaults) throws where Value: Codable {
        // Convert the new value into data for storage.
        let data = try encoder.encode(value)

        // Save the data to the store.
        self.set(data, forKey: key)
    }
}

// MARK: - Supporting Types

public extension JSONEncoder {
    static let userDefaults = JSONEncoder()
}

public extension JSONDecoder {
    static let userDefaults = JSONDecoder()
}

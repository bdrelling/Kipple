// Copyright © 2024 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

import Foundation
import KeychainAccess

public extension Keychain {
    /// A wrapper around a `String` that allows strongly typed `Keychain` keys with an extensible `enum`-like syntax.
    /// This value can then be extended by consumers that wish to fetch values out of `Keychain`.
    ///
    /// Example:
    ///
    /// ```swift
    /// public extension Keychain.Key {
    ///     static let userID: Self = "userID"
    /// }
    /// ```
    ///
    /// After adding the key, you can use it like so:
    ///
    /// ```swift
    /// // Get a value
    /// let userID = try self.get(.userID)
    ///
    /// // Set a value
    /// try self.set(newValue, key: .userID)
    ///
    /// // Remove a value
    /// try self.remove(.userID)
    /// ```
    ///
    /// You could also add an extension property, though you lose error-throwing functionality.
    ///
    /// ```swift
    /// extension Keychain {
    ///     public var userID: String? {
    ///         get {
    ///             try? self.get(.userID)
    ///         }
    ///
    ///         set {
    ///             if let newValue {
    ///                 try? self.set(newValue, key: .userID)
    ///             } else {
    ///                 try? self.remove(.userID)
    ///             }
    ///         }
    ///     }
    /// }
    ///
    /// ```
    struct Key: RawRepresentable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

// MARK: - Convenience

// MARK: - Extensions

extension Keychain.Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(rawValue: value)
    }
}

public extension Keychain {
    // MARK: Subscript

    subscript(key: Key) -> String? {
        self[key.rawValue]
    }

    subscript(string key: Key) -> String? {
        self[string: key.rawValue]
    }

    subscript(data key: Key) -> Data? {
        self[data: key.rawValue]
    }

    subscript(attributes key: Key) -> Attributes? {
        self[attributes: key.rawValue]
    }

    // MARK: Get

    func get(_ key: Key, ignoringAttributeSynchronizable: Bool = true) throws -> String? {
        try self.get(key.rawValue, ignoringAttributeSynchronizable: ignoringAttributeSynchronizable)
    }

    func getString(_ key: Key, ignoringAttributeSynchronizable: Bool = true) throws -> String? {
        try self.getString(key.rawValue, ignoringAttributeSynchronizable: ignoringAttributeSynchronizable)
    }

    func getData(_ key: Key, ignoringAttributeSynchronizable: Bool = true) throws -> Data? {
        try self.getData(key.rawValue, ignoringAttributeSynchronizable: ignoringAttributeSynchronizable)
    }

    func get<T>(_ key: Key, ignoringAttributeSynchronizable: Bool = true, handler: (Attributes?) -> T) throws -> T {
        try self.get(key.rawValue, ignoringAttributeSynchronizable: ignoringAttributeSynchronizable, handler: handler)
    }

    // MARK: Set

    func set(_ value: String, key: Key, ignoringAttributeSynchronizable: Bool = true) throws {
        try self.set(value, key: key.rawValue, ignoringAttributeSynchronizable: ignoringAttributeSynchronizable)
    }

    func set(_ value: Data, key: Key, ignoringAttributeSynchronizable: Bool = true) throws {
        try self.set(value, key: key.rawValue, ignoringAttributeSynchronizable: ignoringAttributeSynchronizable)
    }

    // MARK: Remove

    func remove(_ key: Key, ignoringAttributeSynchronizable: Bool = true) throws {
        try self.remove(key.rawValue, ignoringAttributeSynchronizable: ignoringAttributeSynchronizable)
    }

    // MARK: Contains

    func contains(_ key: Key, withoutAuthenticationUI: Bool = false) throws -> Bool {
        try self.contains(key.rawValue, withoutAuthenticationUI: withoutAuthenticationUI)
    }
}

#endif

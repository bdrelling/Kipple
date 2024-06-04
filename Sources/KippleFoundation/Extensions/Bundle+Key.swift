// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension Bundle {
    /// A wrapper around a `String` that allows strongly typed `Bundle` keys with an extensible `enum`-like syntax.
    /// This value can then be extended by consumers that wish to fetch values out of `Bundle`.
    ///
    /// Example:
    ///
    /// ```swift
    /// public extension Bundle.Key {
    ///     static let name: Self = "CFBundleName"
    /// }
    /// ```
    struct Key: RawRepresentable, Codable, Sendable, Equatable, Hashable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

// MARK: - Convenience

public extension Bundle.Key {
    static let buildNumber: Self = "CFBundleVersion"
    static let displayName: Self = "CFBundleDisplayName"
    static let name: Self = "CFBundleName"
    static let version: Self = "CFBundleShortVersionString"
}

// MARK: - Extensions

extension Bundle.Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(rawValue: value)
    }
}

public extension Bundle {
    /// Returns a generic value from this `Bundle`'s `Info.plist`.
    func infoDictionaryValue<T>(for key: Key, in bundle: Bundle = .main) -> T? {
        self.infoDictionaryValue(for: key.rawValue, in: bundle)
    }

    /// Returns a `String` value from this `Bundle`'s `Info.plist`.
    func infoDictionaryString(for key: Key, in bundle: Bundle = .main) -> String? {
        self.infoDictionaryValue(for: key, in: bundle)
    }
}

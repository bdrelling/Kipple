// Copyright © 2024 Brian Drelling. All rights reserved.

@testable import KippleStorage
import XCTest

final class UserDefaultsExtensionsTests: XCTestCase {
    func testDefaultValue() throws {
        let store: UserDefaults = .mocked

        // Ensure there is no value currently stored the test key.
        let username: String? = try store.codable(forKey: .username)
        XCTAssertNil(username)

        // As there is no value stored for the key, the default value should be returned.
        XCTAssertEqual(store.codable(forKey: .username, defaultValue: "brian"), "brian")
    }

    func testSettingExistingKeys() throws {
        let store: UserDefaults = .mocked

        // Set a key to an initial value.
        try store.set(codableValue: "brian", forKey: .username)
        try XCTAssertEqual(store.codable(forKey: .username), "brian")

        // Set the same key to a new value.
        try store.set(codableValue: "drelling", forKey: .username)
        try XCTAssertEqual(store.codable(forKey: .username), "drelling")
    }

    func testRemovingSpecificKey() throws {
        let store: UserDefaults = .mocked

        try store.set(codableValue: 42, forKey: "Foo")

        // Ensure the values for the key has been set correctly.
        try XCTAssertEqual(store.codable(forKey: "Foo"), 42)

        // Remove the key.
        store.removeObject(forKey: "Foo")

        // Ensure the key and value have been removed from the store.
        let value: Int? = try store.codable(forKey: "Foo")
        XCTAssertNil(value)
    }

    func testRemovingAllKeys() throws {
        let store: UserDefaults = .mocked

        // Set values for multiple keys.
        try store.set(codableValue: 42, forKey: "Foo")
        try store.set(codableValue: "Hello", forKey: .username)

        // Ensure the values for each key have been set correctly.
        try XCTAssertEqual(store.codable(forKey: "Foo"), 42)
        try XCTAssertEqual(store.codable(forKey: .username), "Hello")

        // Remove all objects from the store.
        store.removeAllObjects()

        // Fetch our values.
        let firstValue: Int? = try store.codable(forKey: "Foo")
        let secondValue: Int? = try store.codable(forKey: .username)

        // Ensure all values are nil, indicating the store has successfully removed all keys.
        XCTAssertNil(firstValue)
        XCTAssertNil(secondValue)
    }
}

// MARK: - Extensions

private extension UserDefaults.Key {
    static let username: Self = "username"
}

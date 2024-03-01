// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleCodable
import XCTest

final class EncodableAsDictionaryTests: XCTestCase {
    let encoder = JSONEncoder()

    func testAsDictionaryEncodingSucceeds() throws {
        // Given
        let person = Person(name: "Alice", age: 30)

        // When
        let dictionary = try person.asDictionary(encoder: self.encoder)

        // Then
        XCTAssertNotNil(dictionary)
        XCTAssertEqual(dictionary?["name"] as? String, "Alice")
        XCTAssertEqual(dictionary?["age"] as? Int, 30)
    }
}

// MARK: - Supporting Types

private struct Person: Codable {
    let name: String
    let age: Int
}

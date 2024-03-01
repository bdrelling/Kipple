// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleCodable
import XCTest

final class DictionaryExtensionTests: XCTestCase {
    func testAsJSONSerializedData() throws {
        // Given
        let dictionary: [String: Any] = [
            "name": "Alice",
            "age": 30,
        ]

        // When
        let jsonData = try dictionary.asJSONSerializedData()

        // Then
        XCTAssertNotNil(jsonData)

        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
        XCTAssertNotNil(jsonObject)

        guard let serializedDictionary = jsonObject as? [String: Any] else {
            XCTFail("Failed to cast serialized data to dictionary")
            return
        }

        XCTAssertEqual(serializedDictionary["name"] as? String, "Alice")
        XCTAssertEqual(serializedDictionary["age"] as? Int, 30)
    }
}

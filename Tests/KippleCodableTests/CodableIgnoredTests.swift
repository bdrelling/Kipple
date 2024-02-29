// Copyright © 2024 Brian Drelling. All rights reserved.

@testable import KippleCodable
import XCTest

final class CodableIgnoredTests: XCTestCase {
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        return encoder
    }()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    /// Verify that the property wrapped with `CodableIgnored` is not encoded.
    func testEncodingSucceeds() throws {
        // Given
        let example = Example(control: 1, ignoredValue: "test")
        
        // When
        let data = try encoder.encode(example)
        
        // Then
        let decodedDictionary = try XCTUnwrap(try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])
        XCTAssertNil(decodedDictionary["ignoredValue"])
    }
    
    /// Verify that the property wrapped with `CodableIgnored` is not decoded.
    func testDecodingSucceeds() throws {
        // Given
        let json = #"{"control":1,"ignoredValue":"test"}"#
        let decodeData = try XCTUnwrap(json.data(using: .utf8))
        
        // When
        let example = try decoder.decode(Example.self, from: decodeData)
        
        // Then
        XCTAssertEqual(example.control, 1)
        XCTAssertNil(example.ignoredValue)
    }
}

// MARK: - Supporting Types

private struct Example: Codable {
    let control: Int

    @CodableIgnored private(set) var ignoredValue: String?

    init(control: Int, ignoredValue: String? = nil) {
        self.control = control
        self.ignoredValue = ignoredValue
    }
}

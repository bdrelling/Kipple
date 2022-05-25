// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import KippleCodable
import XCTest

final class CodableDefaultTests: XCTestCase {
    /// `emptyString` is `""`, and therefore _should not_ get encoded.
    func testEncodingDefaultValueSucceeds() throws {
        let example = Example(control: 1, emptyString: "")
        let data = try JSONEncoder().encode(example)
        let actualJSON = try XCTUnwrap(String(data: data, encoding: .utf8))

        let expectedJSON = #"{"control":1}"#

        XCTAssertEqual(actualJSON, expectedJSON)
    }
    
    /// `emptyString` is `"Boo"`, and therefore _should_ get encoded.
    func testEncodingNonDefaultValueSucceeds() throws {
        let example = Example(control: 1, emptyString: "Boo")
        let data = try JSONEncoder().encode(example)
        let actualJSON = try XCTUnwrap(String(data: data, encoding: .utf8))

        let expectedJSON = #"{"control":1,"emptyString":"Boo"}"#

        XCTAssertEqual(actualJSON, expectedJSON)
    }
    
    /// `emptyString` is missing from the JSON string, and therefore should end up setting `emptyString` to its default value of `""`.
    func testDecodingMissingValueSucceeds() throws {
        let json = #"{"control":1}"#
        let decodeData = try XCTUnwrap(json.data(using: .utf8))
        let example = try JSONDecoder().decode(Example.self, from: decodeData)

        XCTAssertEqual(example.control, 1)
        XCTAssertEqual(example.emptyString, "")
    }
    
    /// `emptyString` is `"Boo"`, and therefore _should_ get decoded.
    func testingDecodingNonDefaultValueSucceeds() throws {
        let json = #"{"control":1,"emptyString":"Boo"}"#
        let decodeData = try XCTUnwrap(json.data(using: .utf8))
        let example = try JSONDecoder().decode(Example.self, from: decodeData)

        XCTAssertEqual(example.control, 1)
        XCTAssertEqual(example.emptyString, "Boo")
    }
}

// MARK: - Supporting Types

private struct Example: Codable {
    let control: Int
    
    @DefaultEmptyString private(set) var emptyString: String
    @DefaultTrue private(set) var trueBool: Bool
    @DefaultFalse private(set) var falseBool: Bool
    
    init(control: Int,
         emptyString: String? = nil,
         trueBool: Bool? = nil,
         falseBool: Bool? = nil
    ) {
        self.control = control
        
        if let emptyString = emptyString {
            self.emptyString = emptyString
        }
        
        if let trueBool = trueBool {
            self.trueBool = trueBool
        }
        
        if let falseBool = falseBool {
            self.falseBool = falseBool
        }
    }
}

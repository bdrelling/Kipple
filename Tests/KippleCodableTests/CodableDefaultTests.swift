// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import KippleCodable
import XCTest

final class CodableDefaultTests: XCTestCase {
    func testEncodingDefault() throws {
        let example = Example(control: 1, emptyString: "")
        let data = try JSONEncoder().encode(example)
        let actualJSON = try XCTUnwrap(String(data: data, encoding: .utf8))

        let expectedJSON = #"{"control":1}"#

        XCTAssertEqual(actualJSON, expectedJSON)
    }
    
    func testEncodingNonDefault() throws {
        let example = Example(control: 1, emptyString: "Foo")
        let data = try JSONEncoder().encode(example)
        let actualJSON = try XCTUnwrap(String(data: data, encoding: .utf8))

        let expectedJSON = #"{"control":1,"emptyString":"Foo"}"#

        XCTAssertEqual(actualJSON, expectedJSON)
    }
    
    func testDecoding() throws {
        let json = #"{"control":1}"#
        let decodeData = try XCTUnwrap(json.data(using: .utf8))
        let example = try JSONDecoder().decode(Example.self, from: decodeData)

        XCTAssertEqual(example.control, 1)
        XCTAssertEqual(example.emptyString, "")
    }
}

// MARK: - Supporting Types

private struct Example: Codable {
    let control: Int
    
    @CodableDefault<EmptyString> private(set) var emptyString: String
    
    init(control: Int, emptyString: String) {
        self.control = control
        self.emptyString = emptyString
    }
}

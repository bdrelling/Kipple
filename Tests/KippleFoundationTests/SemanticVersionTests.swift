// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleFoundation
import XCTest

final class SemanticVersionTests: XCTestCase {
    func testRawValue() throws {
        let version = SemanticVersion(major: 1, minor: 2, patch: 3)
        XCTAssertEqual(version.rawValue, "1.2.3")
    }

    func testStringInitialization() throws {
        let version: SemanticVersion = "1.2.3"

        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertEqual(version.patch, 3)

        // Ensure raw value remains unchanged
        XCTAssertEqual(version.rawValue, "1.2.3")
    }

    func testStringInitializationWithOddValues() throws {
        let version: SemanticVersion = "1.20240227.35"

        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 20240227)
        XCTAssertEqual(version.patch, 35)

        // Ensure raw value remains unchanged
        XCTAssertEqual(version.rawValue, "1.20240227.35")
    }

    func testStringInitializationWithoutPatch() throws {
        let version: SemanticVersion = "1.2"

        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertEqual(version.patch, 0)

        // Ensure raw value remains unchanged
        XCTAssertEqual(version.rawValue, "1.2.0")
    }

    func testStringInitializationFailures() throws {
        XCTAssertEqual(SemanticVersion(stringLiteral: "1").rawValue, "0.0.0")
        XCTAssertEqual(SemanticVersion(stringLiteral: "").rawValue, "0.0.0")
        XCTAssertEqual(SemanticVersion(stringLiteral: "abc").rawValue, "0.0.0")
    }

    func testEquatability() throws {
        let lhs: SemanticVersion = "1.2.3"
        let rhs: SemanticVersion = "1.2.3"

        XCTAssertEqual(lhs, rhs)
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import XCTest

final class StringExtensionTests: XCTestCase {
    func testReplacingTabsWithSpaces() {
        // Given
        let input = "Hello\tWorld!"
        let expectedOutput = "Hello    World!"

        // When
        let result = input.replacingTabsWithSpaces()

        // Then
        XCTAssertEqual(result, expectedOutput)
    }

    func testTrimmingSlashes() {
        // Given
        let input = "/path/to/directory/"
        let expectedOutput = "path/to/directory"

        // When
        let result = input.trimmingSlashes()

        // Then
        XCTAssertEqual(result, expectedOutput)
    }

    func testBase64Encoding() {
        // Given
        let input = "Hello, World!"
        let expectedOutput = "SGVsbG8sIFdvcmxkIQ=="

        // When
        let result = input.base64Encoded()

        // Then
        XCTAssertEqual(result, expectedOutput)
    }
}

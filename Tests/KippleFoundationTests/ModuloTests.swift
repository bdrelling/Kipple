// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleFoundation
import XCTest

final class ModuloTests: XCTestCase {
    func testModuloPositiveNumbers() {
        // Given
        let dividend = 10
        let divisor = 3
        let expectedRemainder = 1

        // When
        let result = modulo(dividend, divisor)

        // Then
        XCTAssertEqual(result, expectedRemainder)
    }

    func testModuloNegativeNumbers() {
        // Given
        let dividend: Int = -10
        let divisor = 3
        let expectedRemainder = 2

        // When
        let result = modulo(dividend, divisor)

        // Then
        XCTAssertEqual(result, expectedRemainder)
    }

    func testModuloZeroDivisor() {
        // Given
        let dividend = 10
        let divisor = 0
        let expectedRemainder = 0 // Not defined, should return 0

        // When
        let result = modulo(dividend, divisor)

        // Then
        XCTAssertEqual(result, expectedRemainder)
    }
}

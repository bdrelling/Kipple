// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleFoundation
import XCTest

final class IntExtensionTests: XCTestCase {
    func testIsEven() {
        // Given
        let evenNumber = 4
        let oddNumber = 5

        // When
        let isEvenResult = evenNumber.isEven
        let isOddResult = oddNumber.isEven

        // Then
        XCTAssertTrue(isEvenResult)
        XCTAssertFalse(isOddResult)
    }
}

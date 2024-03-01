// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleFoundation
import XCTest

final class UInt64ClampedTests: XCTestCase {
    // MARK: Int64

    func testClampedInt64WithinRange() {
        // Given
        let uint64Value: UInt64 = 42

        // When
        let int64Value = uint64Value.clampedInt64()

        // Then
        XCTAssertEqual(int64Value, 42)
    }

    func testClampedInt64ExceedsRange() {
        // Given
        let uint64Value = UInt64(Int64.max) + 1

        // When
        let int64Value = uint64Value.clampedInt64()

        // Then
        XCTAssertEqual(int64Value, Int64.max)
    }

    // MARK: Int32

    func testClampedInt32WithinRange() {
        // Given
        let uint64Value: UInt64 = 42

        // When
        let int32Value = uint64Value.clampedInt32()

        // Then
        XCTAssertEqual(int32Value, 42)
    }

    func testClampedInt32ExceedsRange() {
        // Given
        let uint64Value = UInt64(Int32.max) + 1

        // When
        let int32Value = uint64Value.clampedInt32()

        // Then
        XCTAssertEqual(int32Value, Int32.max)
    }

    // MARK: Int

    func testClampedIntWithinRange() {
        // Given
        let uint64Value: UInt64 = 42

        // When
        let intValue = uint64Value.clampedInt()

        // Then
        XCTAssertEqual(intValue, 42)
    }

    func testClampedIntExceedsRange() {
        // Given
        let uint64Value = UInt64(Int.max) + 1

        // When
        let intValue = uint64Value.clampedInt()

        // Then
        XCTAssertEqual(intValue, Int.max)
    }
}

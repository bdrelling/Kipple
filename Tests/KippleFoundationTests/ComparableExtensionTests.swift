// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleFoundation
import XCTest

final class ComparableExtensionTests: XCTestCase {
    func testClamped() {
        XCTAssertEqual(3.clamped(to: 0 ... 6), 3)
        XCTAssertEqual(3.clamped(to: 0 ... 2), 2)
        XCTAssertEqual(3.clamped(to: 4 ... 6), 4)
    }
}

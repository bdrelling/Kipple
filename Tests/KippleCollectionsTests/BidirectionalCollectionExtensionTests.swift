// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleCollections
import XCTest

final class BidirectionalCollectionExtensionTests: XCTestCase {
    func testLooping() {
        let values = [0, 1, 2, 3, 4, 5]

        XCTAssertEqual(values.before(0), nil)
        XCTAssertEqual(values.before(0, loop: true), 5)
        XCTAssertEqual(values.before(1), 0)
        XCTAssertEqual(values.before(2), 1)
        XCTAssertEqual(values.before(3), 2)
        XCTAssertEqual(values.before(4), 3)
        XCTAssertEqual(values.before(5), 4)

        XCTAssertEqual(values.after(0), 1)
        XCTAssertEqual(values.after(1), 2)
        XCTAssertEqual(values.after(2), 3)
        XCTAssertEqual(values.after(3), 4)
        XCTAssertEqual(values.after(4), 5)
        XCTAssertEqual(values.after(5), nil)
        XCTAssertEqual(values.after(5, loop: true), 0)
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleCollections
import XCTest

final class BidirectionalCollectionExtensionTests: XCTestCase {
    func testLooping() {
        let values = [0, 1, 2, 3, 4, 5]

        XCTAssertEqual(values.previous(before: 0), nil)
        XCTAssertEqual(values.previous(looping: true, before: 0), 5)
        XCTAssertEqual(values.previous(before: 1), 0)
        XCTAssertEqual(values.previous(before: 2), 1)
        XCTAssertEqual(values.previous(before: 3), 2)
        XCTAssertEqual(values.previous(before: 4), 3)
        XCTAssertEqual(values.previous(before: 5), 4)

        XCTAssertEqual(values.next(after: 0), 1)
        XCTAssertEqual(values.next(after: 1), 2)
        XCTAssertEqual(values.next(after: 2), 3)
        XCTAssertEqual(values.next(after: 3), 4)
        XCTAssertEqual(values.next(after: 4), 5)
        XCTAssertEqual(values.next(after: 5), nil)
        XCTAssertEqual(values.next(looping: true, after: 5), 0)
    }
}

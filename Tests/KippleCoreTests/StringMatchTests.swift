// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleCore
import XCTest

final class StringMatchTests: XCTestCase {
    private let pattern = #"([a-z0-9|-]+)+\.[a-z0-9|-]+\.[a-z]+"#

    func testSingleMatch() {
        let string = "www.briandrelling.com"
        let matches = string.matches(for: self.pattern)

        XCTAssertEqual(matches.count, 1)
    }

    func testMultipleMatches() {
        let string = """
        hello
        www.briandrelling.com
        api.briandrelling.com
        """
        let matches = string.matches(for: self.pattern)

        XCTAssertEqual(matches.count, 2)
    }

    func testNoMatches() {
        let string = "briandrelling.com"
        let matches = string.matches(for: self.pattern)

        XCTAssertEqual(matches.count, 0)
    }
}

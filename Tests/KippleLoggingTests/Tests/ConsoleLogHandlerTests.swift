// Copyright © 2024 Brian Drelling. All rights reserved.

import XCTest
#if os(Linux) && canImport(Logging)

import KippleLogging

final class ConsoleLogHandlerTests: XCTestCase, LogHandlerValidating {
    func testLogHandlerConformanceIsValid() {
        self.validateLogLevel(ConsoleLogHandler.init)
    }
}

#endif

final class Tests: XCTestCase {}

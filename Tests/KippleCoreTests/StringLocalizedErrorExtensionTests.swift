// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleCore
import XCTest

final class StringLocalizedErrorExtensionTests: XCTestCase {
    func testErrorDescription() {
        let message = "An error occurred"
        
        do {
            throw message
        } catch {
            XCTAssertEqual("\(error)", message)
            XCTAssertEqual(error.localizedDescription, message)
        }
    }
}


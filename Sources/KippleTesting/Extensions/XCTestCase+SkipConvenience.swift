// Copyright © 2021 Brian Drelling. All rights reserved.

import XCTest

public extension XCTestCase {
    func skipIfNotMacOS() throws {
        #if !os(macOS)
            throw XCTSkip("Sign in functionality is only available on macOS because it access the Keychain.")
        #endif
    }
}

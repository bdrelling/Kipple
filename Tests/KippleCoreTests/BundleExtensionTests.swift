// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleCore
import XCTest

final class BundleExtensionTests: XCTestCase {
    func testBundleProperties() throws {
        let bundle: Bundle = .main

        // Ensure none of our Strings are empty or nil.
        // NOTE: We can't validate bundleDisplayName in any way currently.
        XCTAssertFalse(bundle.bundleName?.isEmpty ?? true)
        XCTAssertFalse(bundle.bundleFullVersion.isEmpty)

        // Ensure our bundle version and build number are not zero, which would indicate a failure to initialize.
        XCTAssertNotEqual(bundle.bundleVersion, .zero)
        XCTAssertNotEqual(bundle.bundleBuildNumber, 0)

        // Ensure our build number is not equal to our error code.
        XCTAssertNotEqual(bundle.bundleBuildNumber, 34404)
    }
}

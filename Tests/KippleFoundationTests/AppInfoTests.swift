// Copyright © 2024 Brian Drelling. All rights reserved.

#if !os(Linux)

import KippleFoundation
import XCTest

final class AppInfoTests: XCTestCase {
    /// Tests that initialization with a `Bundle` succeeds.
    /// This isn't the best test, but its tricky to test `Bundle` in `XCTest` without some overhead.
    /// Thankfully, our `Bundle` extensions are extremely lightweifht and very stable.
    func testInitializationWithBundle() throws {
        let xctestIdentifier = "com.apple.dt.xctest.tool"
        let bundle: Bundle = try XCTUnwrap(.init(identifier: xctestIdentifier))
        let appInfo = AppInfo(bundle: bundle, appStoreTeamID: "AB12CD34EF")

        XCTAssertEqual(appInfo.identifier, xctestIdentifier)
        XCTAssertEqual(appInfo.name, "xctest")

        // Ensure our app version is not zero, which would indicate a failure to initialize.
        XCTAssertNotEqual(appInfo.version, .zero)
    }

    func testDefaultKeychainAccessGroup() throws {
        // As of Swift 5.9, Bundle.main is XCTest.
        // If this changes, simply print Bundle.main.bundleIdentifier
        // and check Bundle,allBundles.compactMap(\.bundleIdentifier)
        // to see what the right Bundle is to use for this test.
        let bundle: Bundle = try XCTUnwrap(.init(identifier: "com.apple.dt.xctest.tool"))

        let appInfo = AppInfo(bundle: bundle, appStoreTeamID: "AB12CD34EF")
        XCTAssertEqual(appInfo.defaultKeychainAccessGroup, "AB12CD34EF.com.apple.dt.xctest.tool")
    }
}

#endif

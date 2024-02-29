
import KippleCore
import XCTest

final class BundleInfoTests: XCTestCase {
    func testCurrentBundleInfo() {
        // As of Swift 5.9, Bundle.main is XCTest.
        // If this changes, simply print Bundle.main.bundleIdentifier
        // and check Bundle,allBundles.compactMap(\.bundleIdentifier)
        // to see what the right Bundle is to use for this test.
        let bundleInfo: BundleInfo = .current
        
        XCTAssertEqual(bundleInfo.identifier, "com.apple.dt.xctest.tool")
        XCTAssertEqual(bundleInfo.name, "xctest")
        XCTAssertNil(bundleInfo.displayName)
        XCTAssertNotEqual(bundleInfo.version, .zero)
    }
}

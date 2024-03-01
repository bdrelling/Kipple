// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleFoundation
import XCTest

final class BoolExtensionTests: XCTestCase {
    func testBoolExtensions() {
        // True if we're debugging, which should almost always be true
        // unless we're testing a release build for some horrible reason.
        #if DEBUG
        XCTAssertTrue(.isDebugging)
        #else
        XCTAssertFalse(.isDebugging)
        #endif

        // True if we're running on a simulator, which should always be true
        // unless we're running on macOS or Linux, which do not need to run simulators.
        #if targetEnvironment(simulator)
        XCTAssertTrue(.isRunningOnSimulator)
        #else
        XCTAssertFalse(.isRunningOnSimulator)
        #endif

        // True if we're either debugging or running on a simulator,
        // which should almost always be true unless any of the exceptions above take place.
        XCTAssertEqual(.isRunningPrivateBuild, .isDebugging || .isRunningOnSimulator)

        

        // Always false as tests don't run inside of Xcode Previews.
        XCTAssertFalse(.isRunningInXcodePreview)

        // Always false as tests don't (and can't) run on TestFlight builds.
        XCTAssertFalse(.isRunningOnTestFlight)
    }
    
    func testBoolTestingExtensions() throws {
        #if os(Linux)
        throw XCTSkip("Bool convenience extensions for detecting Unit and UI testing do not work on Linux and always return false.")
        #endif
        
        // Always true when we're running tests.
        XCTAssertTrue(.isRunningTests)
        XCTAssertTrue(.isRunningUnitTests)
        XCTAssertTrue(.shouldMockExternalServices)

        // Always false as we're currently running unit tests, not UI tests.
        XCTAssertFalse(.isRunningUITests)
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleDevice
import XCTest

final class DeviceInfoTests: XCTestCase {
    func testCurrentDeviceInfo() throws {
        let device: DeviceInfo = .current

        // Ensure our system version is not zero, which would indicate a failure to initialize.
        XCTAssertNotEqual(device.systemVersion, .zero)

        // Ensure our device model and system name are not empty, which would indicate a failure to initialize.
        XCTAssertFalse(device.deviceModel.isEmpty)
        XCTAssertFalse(device.systemName.isEmpty)

        // Our tests should never run on an unknown device.
        XCTAssertNotEqual(device.deviceFamily, .unknown)
    }
}

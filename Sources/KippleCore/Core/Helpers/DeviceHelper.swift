// Copyright © 2021 Brian Drelling. All rights reserved.

import UIDeviceComplete
import UIKit

public enum DeviceHelper {
    private static var device: UIDevice {
        UIDevice.current
    }

    public static var deviceFamily: String {
        // TODO: This won't work for macOS, tvOS, etc. etc.
        self.device.dc.deviceFamily.rawValue
    }
    
    public static var deviceIdiom: UIUserInterfaceIdiom {
        self.device.userInterfaceIdiom
    }
    
    public static var deviceInfo: DeviceInfo {
        .init(
            appVersion: BundleHelper.appVersion,
            appBuildNumber: BundleHelper.appBuildNumber,
            deviceFamily: self.deviceFamily,
            deviceModel: self.deviceModel,
            systemName: self.systemName,
            systemVersion: self.systemVersion
        )
    }

    public static var deviceIdiomName: String {
        self.deviceIdiom.name
    }

    public static var deviceModel: String {
        self.device.dc.commonDeviceName
    }

    public static var systemName: String {
        self.device.systemName
    }

    public static var systemVersionString: String {
        self.device.systemVersion
    }
    
    public static var systemVersion: SemanticVersion {
        .from(self.systemVersionString)
    }
}

// MARK: - Extensions

private extension UIUserInterfaceIdiom {
    var name: String {
        switch self {
        case .unspecified:
            return "Unspecified"
        case .phone:
            return "Phone"
        case .pad:
            return "Pad"
        case .tv:
            return "TV"
        case .carPlay:
            return "CarPlay"
        case .mac:
            return "Mac"
        @unknown default:
            return "Unknown"
        }
    }
}

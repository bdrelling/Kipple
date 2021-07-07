// Copyright © 2021 Brian Drelling. All rights reserved.

import Foundation

public enum BundleHelper {
    private static let errorVersionString = "vERR"
    private static let errorBuildNumber = 0

    private static let appBuildNumberString: String? = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    private static let appVersionString: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    public static var appBuildNumber: Int {
        guard let buildNumberString = self.appBuildNumberString else {
            return Self.errorBuildNumber
        }

        return Int(buildNumberString) ?? Self.errorBuildNumber
    }

    public static var appVersion: SemanticVersion {
        guard let version = self.appVersionString else {
            return .zero
        }

        return .from(version)
    }

    public static var fullVersion: String {
        guard let version = self.appVersionString else {
            return Self.errorVersionString
        }

        if self.appBuildNumber > 0 {
            return "v\(version)b\(self.appBuildNumber)" // indicates a hosted build
        } else {
            #if DEBUG
                return "v\(version)L" // indicates a local build
            #else
                return Self.errorVersionString
            #endif
        }
    }
}

// Copyright © 2021 Brian Drelling. All rights reserved.

public struct DeviceInfo: Codable {
    // MARK: Properties
    
    public let appVersion: SemanticVersion
    public let appBuildNumber: Int
    public let deviceFamily: String
    public let deviceModel: String
    public let systemName: String
    public let systemVersion: SemanticVersion
    
    // MARK: Initializers

    public init(
        appVersion: SemanticVersion,
        appBuildNumber: Int,
        deviceFamily: String,
        deviceModel: String,
        systemName: String,
        systemVersion: SemanticVersion
    ) {
        self.appVersion = appVersion
        self.appBuildNumber = appBuildNumber
        self.deviceFamily = deviceFamily
        self.deviceModel = deviceModel
        self.systemName = systemName
        self.systemVersion = systemVersion
    }
}

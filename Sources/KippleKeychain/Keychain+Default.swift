// Copyright © 2024 Brian Drelling. All rights reserved.

import KeychainAccess
import KippleCore

// TODO: Write tests
public extension Keychain {
    /// Creates a default `Keychain` for an application represented by an `AppInfo` object.
    func `default`(for appInfo: AppInfo) -> Keychain {
        Keychain(service: appInfo.identifier, accessGroup: appInfo.defaultKeychainAccessGroup)
            .synchronizable(true)
    }
}

// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import Firebase
import KippleFirebase
import XCTest

public protocol FirebaseInitializing: XCTestCase {}

public extension FirebaseInitializing {
    private static var plistFilePath: String? {
        Bundle.main.path(forResource: "GoogleService-Info.testing", ofType: "plist")
    }

    private static var plistOptions: FirebaseOptions? {
        if let plistFilePath = self.plistFilePath {
            return FirebaseOptions(contentsOfFile: plistFilePath)
        } else {
            return nil
        }
    }

    private static var staticOptions: FirebaseOptions? {
        let options = FirebaseOptions(
            googleAppID: "1:696232219856:ios:b7c95696c4e713b22abad5",
            gcmSenderID: ""
        )

        #warning("TODO: Make these properties injectable!")
        options.projectID = "jordandraper-colorful-beta"

        return options
    }

    static func initializeFirebase() {
        if let filePath = Self.plistFilePath {
            FirebaseHelper.initialize(filePath: filePath, isLocal: true)
        }
    }
}

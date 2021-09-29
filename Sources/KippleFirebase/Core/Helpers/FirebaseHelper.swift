// Copyright © 2021 Brian Drelling. All rights reserved.

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

public enum FirebaseHelper {
    // MARK: Constants

    private static let localHostname = "bribook.local"

    // MARK: Enums

    public enum Mode {
        case local
        case beta
        case release
    }

    // MARK: Initializers

    public static func initialize(options: FirebaseOptions, mode: Mode) {
//        FirebaseConfiguration.shared.setLoggerLevel(.debug)

        FirebaseApp.configure(options: options)

        if mode == .local {
            self.initializeForLocalDevelopment()
        }
    }

    public static func initialize(filePath: String, mode: Mode) {
        if let options = FirebaseOptions(contentsOfFile: filePath) {
            self.initialize(options: options, mode: mode)
        } else {
            assertionFailure("Firebase failed to intialize!")
        }
    }

    private static func initializeForLocalDevelopment() {
        // Signs out the locally authenticated user.

        // Auth
        Auth.auth().useEmulator(withHost: self.localHostname, port: 9099)

        // Firestore
        let settings = Firestore.firestore().settings
        settings.host = "\(self.localHostname):8080"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false

        Firestore.firestore().settings = settings
    }
}

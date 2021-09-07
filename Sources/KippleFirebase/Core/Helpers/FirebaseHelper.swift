// Copyright © 2021 Brian Drelling. All rights reserved.

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

public enum FirebaseHelper {
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

        guard mode == .local else {
            return
        }

        Auth.auth().useEmulator(withHost: "localhost", port: 9099)

        let settings = Firestore.firestore().settings
        settings.host = "localhost:8080"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false

        Firestore.firestore().settings = settings

        print("Firebase initialized.")
    }

    public static func initialize(filePath: String, mode: Mode) {
        if let options = FirebaseOptions(contentsOfFile: filePath) {
            self.initialize(options: options, mode: mode)
        } else {
            assertionFailure("Firebase failed to intialize!")
        }
    }
}

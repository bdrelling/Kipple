// Copyright © 2021 Brian Drelling. All rights reserved.

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import KippleDiagnostics

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

    public static func initialize(options: FirebaseOptions, isLocal: Bool, isPersistent: Bool = true) {
        FirebaseApp.configure(options: options)
        KippleLogger.debug("Firebase has been configured.")

        if isLocal {
            self.initializeForLocalDevelopment()
        }
        
        Firestore.firestore().settings.isPersistenceEnabled = isPersistent
    }

    public static func initialize(filePath: String, isLocal: Bool, isPersistent: Bool = true) {
        if let options = FirebaseOptions(contentsOfFile: filePath) {
            self.initialize(options: options, isLocal: isLocal, isPersistent: isPersistent)
        } else {
            KippleLogger.report("Firebase failed to initialize! Unable to find GoogleServices file at '\(filePath)'.")
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

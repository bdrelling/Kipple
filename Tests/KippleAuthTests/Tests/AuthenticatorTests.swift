// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import FirebaseAuth
@testable import KippleFirebaseAuth
import XCTest

final class AuthenticatorTests: XCTestCase, FirebaseAuthenticating, FirebaseInitializing, CombinePublisherTesting {
    // MARK: - Properties

    var defaultTimeout: TimeInterval = 5
    var subscriptions = Set<AnyCancellable>()

    // MARK: - Overrides

    override static func setUp() {
        Self.initializeFirebase()
    }

    override func tearDownWithError() throws {
        try Authenticator.shared.signOut()
    }

    // MARK: Sign In

    func testSignInAnonymously() throws {
        try self.waitForSignIn(.anonymousUser)
    }

    func testSignInWithEmailAndPassword() throws {
        try self.waitForSignIn(.credential(.tester))
    }

    // MARK: Sign Up

    func testSignUpWithEmailAndPassword() throws {
        try self.waitForSignUp(.emailAndPassword(TestData.Users.New.email, TestData.Users.New.password))
    }
}

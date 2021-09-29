// Copyright © 2021 Brian Drelling. All rights reserved.

import KippleAuth
import XCTest

public protocol FirebaseAuthenticating: CombinePublisherTesting {
    associatedtype AuthenticatorType: Authenticator

    var authenticator: AuthenticatorType { get }
}

public extension FirebaseAuthenticating {
    // MARK: Sign In

    func waitForSignIn(_ mode: Authenticator.SignInMode) throws {
        try self.skipIfNotMacOS()

        let expectation = self.expectation(description: "Sign In using '\(mode)' mode.")

        self.authenticator
            .signIn(using: mode)
            .sink(with: expectation) { player in
                switch mode {
                case .anonymousUser:
                    XCTAssertTrue(player.isAnonymous)
                default:
                    break
                }

                // TODO: Write tests
            }
            .store(in: &self.subscriptions)

        self.wait(for: [expectation], timeout: self.defaultTimeout)
    }

    // MARK: Sign Up

    func waitForSignUp(_ mode: Authenticator.SignUpMode) throws {
        try self.skipIfNotMacOS()

        let expectation = self.expectation(description: "Sign In Anonymously")

        self.authenticator
            .signUp(using: mode)
            .sink(with: expectation) { _ in
                // TODO: Write tests
            }
            .store(in: &self.subscriptions)

        self.wait(for: [expectation], timeout: self.defaultTimeout)
    }

    // MARK: Utilities

    func authenticatedUserID() throws -> String {
        try XCTUnwrap(self.authenticator.currentUser?.uid, "Unable to get authenticated user. Ensure that Firebase Emulator Suite is running locally.")
    }
}

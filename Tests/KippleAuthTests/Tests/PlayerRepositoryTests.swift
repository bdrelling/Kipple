// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
@testable import KippleFirebaseAuth
import XCTest

final class PlayerRepositoryTests: XCTestCase, FirebaseAuthenticating, FirebaseInitializing, CombinePublisherTesting {
    // MARK: - Enums

    private enum TestError: Error {
        case noAuthenticatedUser
    }

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

    // MARK: - Tests

//    func testCreatePlayer() throws {
//        try self.waitForSignIn(.anonymousUser)
//
//        #warning("You were here! You need to make it so signing in as a user creates a new player, instead of using this test code")
//        let authenticatedUserID = try self.authenticatedUserID()
//        let player = TestData.Players.new(userID: authenticatedUserID)
//
//        XCTAssertEqual(player.id, authenticatedUserID)
//
//        let expectation = self.expectation(description: "Create New Player")
//
//        PlayerRepository()
//            .create(player)
//            .sink(with: expectation) { _ in
    ////                XCTAssertEqual(newMatch, match)
    ////                XCTAssertNotNil(newMatch.creatorID, authenticatedUserID)
//            }
//            .store(in: &self.subscriptions)
//
//        self.wait(for: [expectation], timeout: self.defaultTimeout)
//    }

    func testAnonymousSignInCreatesNewPlayer() throws {
        let signInExpectation = self.expectation(description: "Sign In")
        let currentPlayerExpectation = self.expectation(description: "Current Player Updated")

        // Register a publisher to listen to the currentPlayer variable.
        Authenticator.shared.$currentPlayer
            .compactMap { $0 }
            .sink(with: currentPlayerExpectation) { player in
                XCTAssertEqual(player.id, Authenticator.shared.currentUser?.uid)
            }
            .store(in: &self.subscriptions)

        // Sign in as an Anonymous User.
        Authenticator.shared.signIn(using: .anonymousUser)
            .fulfill(signInExpectation)
            .store(in: &self.subscriptions)

        self.wait(for: [signInExpectation, currentPlayerExpectation], timeout: self.defaultTimeout)
    }

    #warning("You don't know that this works yet!")
    func testSignInGetsExistingPlayer() throws {
        let signInExpectation = self.expectation(description: "Sign In")
        let currentPlayerExpectation = self.expectation(description: "Current Player Updated")

        // Register a publisher to listen to the currentPlayer variable.
        Authenticator.shared.$currentPlayer
            .compactMap { $0 }
            .sink(with: currentPlayerExpectation) { player in
                XCTAssertEqual(player.id, Authenticator.shared.currentUser?.uid)
            }
            .store(in: &self.subscriptions)

        // Sign in as an Anonymous User.
        Authenticator.shared.signIn(using: .credential(.tester))
            .fulfill(signInExpectation)
            .store(in: &self.subscriptions)

        self.wait(for: [signInExpectation, currentPlayerExpectation], timeout: self.defaultTimeout)
    }
}

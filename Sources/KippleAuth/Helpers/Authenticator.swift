// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import FirebaseAuth
import Foundation
import KippleCore
import KippleDiagnostics

open class Authenticator: ObservableObject {
    // MARK: Enums

    public enum AuthenticationError: Error {
        case cachedUserNotFound
    }

    public enum SignInMode {
        case anonymousUser
        case cachedUser
        case credential(AuthCredential)
        case emailAndPassword(String, String)
        case emailAndSignInLink(String, String)
        case gameCenterOrAnonymousUser
    }

    public enum SignUpMode {
        case emailAndPassword(String, String)
    }

    // MARK: Properties

    @Published public private(set) var currentUser: User?
    @Published public private(set) var isAuthenticated: Bool = false

    private lazy var auth = Auth.auth()

    // MARK: Initializers
    
    public init() {}

    open func initialize() {
        // Register a publisher to update isAuthenticated every time currentUser is updated.
        self.$currentUser
            .map { $0 != nil }
            .assign(to: &self.$isAuthenticated)

        self.currentUser = Auth.auth().currentUser

        // Register a listener for Firebse Auth state changes.
        self.auth.addStateDidChangeListener { _, user in
            if let user = user, user == self.currentUser {
                KippleLogger.debug("User \(user.uid) signed in automatically.")
            } else if let user = user {
                self.currentUser = user

                KippleLogger.debug("User \(user.uid) signed in.")
            } else {
                self.currentUser = nil

                if self.currentUser != nil {
                    KippleLogger.debug("User signed out.")
                }
            }
        }
    }

    // MARK: Sign In

    public func signIn(using mode: SignInMode) -> AnyPublisher<User, Error> {
        Future { promise in
            let completion: AuthDataResultCallback = { result, error in
                if let result = result {
                    promise(.success(result.user))
                } else if let error = error {
                    promise(.failure(error))
                }
            }

            switch mode {
            case .anonymousUser:
                self.auth.signInAnonymously(completion: completion)
            case .cachedUser:
                // TODO: Is this correct? Do I even need to keep this if the auth state change listener is active?
                if let currentUser = self.auth.currentUser {
                    promise(.success(currentUser))
                } else {
                    promise(.failure(AuthenticationError.cachedUserNotFound))
                }
            case let .credential(credential):
                self.auth.signIn(with: credential, completion: completion)
            case let .emailAndPassword(email, password):
                self.auth.signIn(withEmail: email, password: password, completion: completion)
            case let .emailAndSignInLink(email, link):
                self.auth.signIn(withEmail: email, link: link, completion: completion)
            case .gameCenterOrAnonymousUser:
                var cancellable: AnyCancellable?
                cancellable = self.signInWithGameCenter()
                    .flatMap { _ -> AnyPublisher<AuthCredential, Error> in
                        self.getGameCenterCredential()
                    }
                    .sinkResult { result in
                        switch result {
                        case let .success(credential):
                            self.auth.signIn(with: credential, completion: completion)
                        case .failure:
                            // TODO: Log why GameCenter auth failed?
                            self.auth.signInAnonymously(completion: completion)
                        }

                        cancellable?.cancel()
                    }
            }
        }.eraseToAnyPublisher()
    }

    // MARK: Sign Up

    public func signUp(using mode: SignUpMode) -> AnyPublisher<User, Error> {
        Future { promise in
            let completion: AuthDataResultCallback = { result, error in
                if let result = result {
                    promise(.success(result.user))
                } else if let error = error {
                    promise(.failure(error))
                }
            }

            switch mode {
            case let .emailAndPassword(email, password):
                self.auth.createUser(withEmail: email, password: password, completion: completion)
            }
        }.eraseToAnyPublisher()
    }

    // MARK: Sign Out

    public func signOut() throws {
        try self.auth.signOut()
    }

    // MARK: Link Accounts

    func linkCurrentUser(with credential: AuthCredential) -> AnyPublisher<AuthDataResult, Error> {
        Future { promise in
            guard let currentUser = self.currentUser else {
                // TODO: Throw "User Not Authenticated" error?
                return
            }

            currentUser.link(with: credential) { result, error in
                if let error = error {
                    promise(.failure(error))
                } else if let result = result {
                    promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
}

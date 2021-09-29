// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import FirebaseAuth
import GameKit
import UIKit

extension Authenticator {
    func signInWithGameCenter(from hostController: UIViewController? = nil) -> AnyPublisher<GKLocalPlayer, Error> {
        Future { promise in
            let localPlayer = GKLocalPlayer.local

            // NOTE: GameCenter will only allow login 1 time on launch and cannot be re-presented if canceled. It also only allows 3 attempts in sandbox.
            localPlayer.authenticateHandler = { authController, error in
                if localPlayer.isAuthenticated {
                    // Successfully authenticated local Game Center player.
                    promise(.success(localPlayer))
                } else if let authController = authController, let hostController = hostController {
                    // Authenticating local Game Center player...
                    hostController.present(authController, animated: true)
                } else if let error = error {
                    // Unable to authenticate local Game Center player.
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func linkAccountWithGameCenter() -> AnyPublisher<AuthDataResult, Error> {
        self.signInWithGameCenter()
            .flatMap { _ in
                self.getGameCenterCredential()
            }
            .flatMap { credential in
                self.linkCurrentUser(with: credential)
            }
            .eraseToAnyPublisher()
    }

    func getGameCenterCredential() -> AnyPublisher<AuthCredential, Error> {
        Future { promise in
            GameCenterAuthProvider.getCredential { credential, error in
                if let error = error {
                    promise(.failure(error))
                } else if let credential = credential {
                    promise(.success(credential))
                }
            }
        }.eraseToAnyPublisher()
    }
}

//    /// Authenticates the user with GameCenter.
//    ///
//    /// Per the documentation for [GKLocalPlayer.authenticateHandler](https://developer.apple.com/documentation/gamekit/gklocalplayer/1515399-authenticatehandler),
//    /// the game should authenticate the player "as early as possible after launching,
//    /// ideally as soon as you can present a user interface to the player."
//    @discardableResult
//    func authenticate(from hostController: UIViewController) -> Future<GKLocalPlayer, Error> {
//        Future { promise in
//            // NOTE: GameCenter will only allow login 1 time on launch and cannot be re-presented if canceled. It also only allows 3 attempts in sandbox.
//            GKLocalPlayer.local.authenticateHandler = { authController, error in
//                if GKLocalPlayer.local.isAuthenticated {
//                    print("Successfully authenticated local Game Center player.")
//                    promise(.success(GKLocalPlayer.local))
//                } else if let authController = authController {
//                    print("Authenticating local Game Center player...")
//                    hostController.present(authController, animated: true)
//                } else if let error = error {
//                    print("Unable to authenticate local Game Center player.")
//                    promise(.failure(error))
//                }
//            }
//        }
//    }
//
//    func firebaseAuthCredential(for _: GKLocalPlayer) -> AnyPublisher<AuthCredential, Error> {
//        Future { promise in
//            GameCenterAuthProvider.getCredential { credential, error in
//                if let credential = credential {
//                    print("Successfully validated Game Center Firebase Auth credential.")
//                    promise(.success(credential))
//                } else if let error = error {
//                    print("Unable to validate Game Center Firebase Auth credential.")
//                    promise(.failure(error))
//                }
//            }
//        }.eraseToAnyPublisher()
//    }

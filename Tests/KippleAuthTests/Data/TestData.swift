// Copyright © 2021 Brian Drelling. All rights reserved.

@testable import ColorfulSDK
import FirebaseAuth
import Foundation

struct TestData {
//    enum Matches {
//        static let first = Match(
//            id: "kdqvoeXicUD0Z4rluHjU",
//            name: "First Match",
//            status: .starting,
//            settings: .default,
//            createDate: Date(timeIntervalSinceReferenceDate: 0),
//            updateDate: Date(timeIntervalSinceReferenceDate: 0)
//        )
//
//        static func new(creatorID: String) -> Match {
//            .init(
//                name: "New Match",
//                status: .starting,
//                settings: .default,
//                createDate: Date(timeIntervalSinceReferenceDate: 0),
//                updateDate: Date(timeIntervalSinceReferenceDate: 0)
//            )
//        }
//    }
//
//    enum Players {
//        static func new(userID: String) -> Player {
//            .init(
//                id: userID,
//                displayName: "New Player",
//                isAnonymous: true,
//                createDate: Date(timeIntervalSinceReferenceDate: 0),
//                updateDate: Date(timeIntervalSinceReferenceDate: 0),
//                isNewUser: true
//            )
//        }
//    }

    enum Users {
        enum New {
            static let id = "Why6YPaH9jKPaDPxUvqD1jhFnjF8"
            static let email = "new_user@dungeonsandwagons.com"
            static let password = "dungwag"
        }

        enum Tester {
            static let id = "GzG9z4ZbtlhnnTWOi5j8wK9ZUeIU"
            static let email = "tester@dungeonsandwagons.com"
            static let password = "dungwag"
        }
    }
}

extension AuthCredential {
    static let new = EmailAuthProvider.credential(withEmail: TestData.Users.New.email, password: TestData.Users.New.password)
    static let tester = EmailAuthProvider.credential(withEmail: TestData.Users.Tester.email, password: TestData.Users.Tester.password)
}

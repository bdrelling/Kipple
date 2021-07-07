// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

public extension DocumentReference {
    func addSnapshotPromiseListener<T>(_ promise: @escaping Future<T?, Error>.Promise) where T: Decodable {
        self.addSnapshotListener { snapshot, error in
            self.fulfill(promise, snapshot: snapshot, error: error)
        }
    }

    private func fulfill<T>(_ promise: Future<T?, Error>.Promise, snapshot: DocumentSnapshot?, error: Error?) where T: Decodable {
        if let error = error {
            promise(.failure(error))
        }

        let result = Result {
            try snapshot?.data(as: T.self)
        }

        switch result {
        case let .success(.some(match)):
            promise(.success(match))
        case .success(.none):
            promise(.success(nil))
        case let .failure(error):
            promise(.failure(error))
        }
    }
}

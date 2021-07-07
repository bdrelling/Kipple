// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

// Sourced from https://github.com/rever-ai/CombineFirebase
public extension CollectionReference {
    func addDocument(data: [String: Any]) -> AnyPublisher<DocumentReference, Error> {
        var ref: DocumentReference?
        return Future<DocumentReference, Error> { [weak self] promise in
            ref = self?.addDocument(data: data) { error in
                if let error = error {
                    promise(.failure(error))
                } else if let ref = ref {
                    promise(.success(ref))
                }
            }
        }.eraseToAnyPublisher()
    }

    func addDocument<T: Encodable>(from data: T, encoder: Firestore.Encoder = Firestore.Encoder()) -> AnyPublisher<DocumentReference, Error> {
        var ref: DocumentReference?
        return Future<DocumentReference, Error> { [weak self] promise in
            do {
                ref = try self?.addDocument(from: data, encoder: encoder) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else if let ref = ref {
                        promise(.success(ref))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}

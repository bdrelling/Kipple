// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import FirebaseFirestore

// Sourced from https://github.com/rever-ai/CombineFirebase
public extension Firestore {
    func disableNetwork() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            self?.disableNetwork(completion: { error in
                guard let error = error else {
                    promise(.success(()))
                    return
                }
                promise(.failure(error))
            })
        }.eraseToAnyPublisher()
    }

    func enableNetwork() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            self?.enableNetwork(completion: { error in
                guard let error = error else {
                    promise(.success(()))
                    return
                }
                promise(.failure(error))
            })
        }.eraseToAnyPublisher()
    }

    func runTransaction(_ updateBlock: @escaping (Transaction) throws -> Any?) -> AnyPublisher<Any?, Error> {
        self.runTransaction(type: Any.self, updateBlock)
    }

    func runTransaction<T>(type: T.Type, _ updateBlock: @escaping (Transaction) throws -> T?) -> AnyPublisher<T?, Error> {
        Future<T?, Error> { [weak self] promise in
            self?.runTransaction({ transaction, errorPointer in
                do {
                    return try updateBlock(transaction)
                } catch {
                    errorPointer?.pointee = error as NSError
                    return nil
                }
            }, completion: { value, error in
                guard let error = error else {
                    promise(.success(value as? T))
                    return
                }
                promise(.failure(error))
            })
        }.eraseToAnyPublisher()
    }
}

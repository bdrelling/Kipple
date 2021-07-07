// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

public typealias DocumentMapper<D> = (DocumentSnapshot) throws -> D?

// Sourced from https://github.com/rever-ai/CombineFirebase
public extension DocumentReference {
    var cacheFirstGetDocument: AnyPublisher<DocumentSnapshot, Error> {
        self.getDocument(source: .cache)
            .catch { error -> AnyPublisher<DocumentSnapshot, Error> in
                print("error loading from cache for path \(self.path): \(error)")
                return self.getDocument(source: .server)
            }.eraseToAnyPublisher()
    }

    func setData(_ documentData: [String: Any]) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            self?.setData(documentData) { error in
                guard let error = error else {
                    promise(.success(()))
                    return
                }
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func setData<T: Encodable>(from data: T, encoder: Firestore.Encoder = Firestore.Encoder()) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            do {
                // TODO: Get the ref from setData, then set the ID of data: T if it matches a protocol.
                try self?.setData(from: data, encoder: encoder) { error in
                    guard let error = error else {
                        promise(.success(()))
                        return
                    }
                    promise(.failure(error))
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func setData(_ documentData: [String: Any], merge: Bool) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            self?.setData(documentData, merge: merge) { error in
                guard let error = error else {
                    promise(.success(()))
                    return
                }
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func setData<T: Encodable>(from data: T, merge: Bool, encoder: Firestore.Encoder = Firestore.Encoder()) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            do {
                try self?.setData(from: data, merge: merge, encoder: encoder) { error in
                    guard let error = error else {
                        promise(.success(()))
                        return
                    }
                    promise(.failure(error))
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func updateData(_ fields: [AnyHashable: Any]) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            self?.updateData(fields) { error in
                guard let error = error else {
                    promise(.success(()))
                    return
                }
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func delete() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            self?.delete { error in
                guard let error = error else {
                    promise(.success(()))
                    return
                }
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func publisher(includeMetadataChanges: Bool = true) -> AnyPublisher<DocumentSnapshot, Error> {
        Publisher(self, includeMetadataChanges: includeMetadataChanges)
            .eraseToAnyPublisher()
    }

    func publisher<D: Decodable>(includeMetadataChanges: Bool = true, as type: D.Type, documentSnapshotMapper: @escaping DocumentMapper<D> = DocumentSnapshot.defaultMapper()) -> AnyPublisher<D?, Error> {
        self.publisher(includeMetadataChanges: includeMetadataChanges)
            .map {
                do {
                    return try documentSnapshotMapper($0)
                } catch {
                    print("Document snapshot mapper error for \(self.path): \(error)")
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }

    func getDocument(source: FirestoreSource = .default) -> AnyPublisher<DocumentSnapshot, Error> {
        Future<DocumentSnapshot, Error> { [weak self] promise in
            self?.getDocument(source: source, completion: { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let snapshot = snapshot {
                    promise(.success(snapshot))
                } else {
                    promise(.failure(FirestoreError.nilResultError))
                }
            })
        }.eraseToAnyPublisher()
    }

    func getDocument<D: Decodable>(source: FirestoreSource = .default, as type: D.Type, documentSnapshotMapper: @escaping DocumentMapper<D> = DocumentSnapshot.defaultMapper()) -> AnyPublisher<D?, Error> {
        self.getDocument(source: source).map {
            do {
                return try documentSnapshotMapper($0)
            } catch {
                print("error for \(self.path): \(error)")
                return nil
            }
        }
        .eraseToAnyPublisher()
    }

    func cacheFirstGetDocument<D: Decodable>(as type: D.Type, documentSnapshotMapper: @escaping DocumentMapper<D> = DocumentSnapshot.defaultMapper()) -> AnyPublisher<D?, Error> {
        self.cacheFirstGetDocument.map {
            do {
                return try documentSnapshotMapper($0)
            } catch {
                print("error for \(self.path): \(error)")
                return nil
            }
        }
        .eraseToAnyPublisher()
    }
}

extension DocumentReference {
    struct Publisher: Combine.Publisher {
        typealias Output = DocumentSnapshot
        typealias Failure = Error

        private let documentReference: DocumentReference
        private let includeMetadataChanges: Bool

        init(_ documentReference: DocumentReference, includeMetadataChanges: Bool) {
            self.documentReference = documentReference
            self.includeMetadataChanges = includeMetadataChanges
        }

        func receive<S>(subscriber: S) where S: Subscriber, Publisher.Failure == S.Failure, Publisher.Output == S.Input {
            let subscription = DocumentSnapshot.Subscription(subscriber: subscriber, documentReference: self.documentReference, includeMetadataChanges: self.includeMetadataChanges)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension DocumentSnapshot {
    fileprivate final class Subscription<SubscriberType: Subscriber>: Combine.Subscription where SubscriberType.Input == DocumentSnapshot, SubscriberType.Failure == Error {
        private var registration: ListenerRegistration?

        init(subscriber: SubscriberType, documentReference: DocumentReference, includeMetadataChanges: Bool) {
            self.registration = documentReference.addSnapshotListener(includeMetadataChanges: includeMetadataChanges) { snapshot, error in
                if let error = error {
                    subscriber.receive(completion: .failure(error))
                } else if let snapshot = snapshot {
                    _ = subscriber.receive(snapshot)
                } else {
                    subscriber.receive(completion: .failure(FirestoreError.nilResultError))
                }
            }
        }

        func request(_ demand: Subscribers.Demand) {
            // We do nothing here as we only want to send events when they occur.
            // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
        }

        func cancel() {
            self.registration?.remove()
            self.registration = nil
        }
    }

    public static func defaultMapper<D: Decodable>() -> DocumentMapper<D> {
        {
            do {
                return try $0.data(as: D.self)
            } catch let decodingError as DecodingError {
                print("Error decoding Firestore Document into '\(String(describing: D.self))'. \(decodingError.cleanedDescription)")
                throw decodingError
            }
        }
    }
}

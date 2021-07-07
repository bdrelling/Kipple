// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import FirebaseFirestore

public typealias QueryMapper<D> = (QuerySnapshot, DocumentMapper<D>) throws -> [D]

// Sourced from https://github.com/rever-ai/CombineFirebase
public extension Query {
    func publisher(includeMetadataChanges: Bool = true) -> AnyPublisher<QuerySnapshot, Error> {
        Publisher(self, includeMetadataChanges: includeMetadataChanges)
            .eraseToAnyPublisher()
    }

    func publisher<D: Decodable>(includeMetadataChanges: Bool = true, as type: D.Type, documentSnapshotMapper: @escaping DocumentMapper<D> = DocumentSnapshot.defaultMapper(), querySnapshotMapper: @escaping QueryMapper<D> = QuerySnapshot.defaultMapper()) -> AnyPublisher<[D], Error> {
        self.publisher(includeMetadataChanges: includeMetadataChanges)
            .tryMap { try querySnapshotMapper($0, documentSnapshotMapper) }
            .eraseToAnyPublisher()
    }

    func getDocuments(source: FirestoreSource = .default) -> AnyPublisher<QuerySnapshot, Error> {
        Future<QuerySnapshot, Error> { [weak self] promise in
            self?.getDocuments(source: source, completion: { snapshot, error in
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

    func getDocuments<D: Decodable>(source: FirestoreSource = .default, as type: D.Type, documentSnapshotMapper: @escaping DocumentMapper<D> = DocumentSnapshot.defaultMapper(), querySnapshotMapper: @escaping QueryMapper<D> = QuerySnapshot.defaultMapper()) -> AnyPublisher<[D], Error> {
        self.getDocuments(source: source)
            .tryMap { try querySnapshotMapper($0, documentSnapshotMapper) }
            .eraseToAnyPublisher()
    }
}

extension Query {
    struct Publisher: Combine.Publisher {
        typealias Output = QuerySnapshot
        typealias Failure = Error

        private let query: Query
        private let includeMetadataChanges: Bool

        init(_ query: Query, includeMetadataChanges: Bool) {
            self.query = query
            self.includeMetadataChanges = includeMetadataChanges
        }

        func receive<S>(subscriber: S) where S: Subscriber, Publisher.Failure == S.Failure, Publisher.Output == S.Input {
            let subscription = QuerySnapshot.Subscription(subscriber: subscriber, query: self.query, includeMetadataChanges: self.includeMetadataChanges)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension QuerySnapshot {
    fileprivate final class Subscription<SubscriberType: Subscriber>: Combine.Subscription where SubscriberType.Input == QuerySnapshot, SubscriberType.Failure == Error {
        private var registration: ListenerRegistration?

        init(subscriber: SubscriberType, query: Query, includeMetadataChanges: Bool) {
            self.registration = query.addSnapshotListener(includeMetadataChanges: includeMetadataChanges) { querySnapshot, error in
                if let error = error {
                    subscriber.receive(completion: .failure(error))
                } else if let querySnapshot = querySnapshot {
                    _ = subscriber.receive(querySnapshot)
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

    public static func defaultMapper<D: Decodable>() -> QueryMapper<D> {
        { snapshot, documentSnapshotMapper in
            try snapshot.documents.compactMap { try documentSnapshotMapper($0) }
        }
    }

//    public static func defaultMapper<D: Decodable>() -> QueryMapper<D> {
//        { snapshot, documentSnapshotMapper in
//            var dArray: [D] = []
//            snapshot.documents.forEach {
//                do {
//                    if let d = try documentSnapshotMapper($0) {
//                        dArray.append(d)
//                    }
//                } catch {
//                    print("Document snapshot mapper error for \($0.reference.path): \(error)")
//                }
//            }
//            return dArray
//        }
//    }
}

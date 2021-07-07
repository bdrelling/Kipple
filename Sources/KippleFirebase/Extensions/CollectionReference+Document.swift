// Copyright © 2021 Brian Drelling. All rights reserved.

import FirebaseFirestore

public extension CollectionReference {
    func document(_ path: String?) -> DocumentReference {
        if let path = path {
            return self.document(path)
        } else {
            return self.document()
        }
    }
}

// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension UserDefaults {
    /// Removes all objects currently stored within this object.
    ///
    /// Note: While system keys are returned alongside custom keys when fetching the dictionary representation,
    /// system keys cannot be removed, so they are passed by gracefully.
    func removeAllObjects() {
        self.dictionaryRepresentation().keys.forEach(self.removeObject(forKey:))
    }
}

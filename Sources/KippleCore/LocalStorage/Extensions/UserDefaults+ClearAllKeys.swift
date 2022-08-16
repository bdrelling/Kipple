// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension UserDefaults {
    // source: https://stackoverflow.com/a/43402172/706771
    func clearAllKeys() {
        self.dictionaryRepresentation().keys.forEach(self.removeObject(forKey:))
    }
}

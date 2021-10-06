// Copyright © 2021 Brian Drelling. All rights reserved.

import SwiftUI

public extension Font.TextStyle {
    var defaultSystemSize: CGFloat {
        Font.preferredFont(forTextStyle: self).pointSize
    }
}

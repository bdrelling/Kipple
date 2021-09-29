// Copyright © 2021 Brian Drelling. All rights reserved.

import KippleCore
import SwiftUI

@available(iOS 14.0, *)
public extension Color {
    func lighter(byPercentage percentage: CGFloat) -> Color {
        self.adjusted(byPercentage: abs(percentage))
    }

    func darker(byPercentage percentage: CGFloat) -> Color {
        self.adjusted(byPercentage: abs(percentage) * -1)
    }

    func adjusted(byPercentage percentage: CGFloat) -> Color {
        let currentUIColor = UIColor(self)

        let adjustedUIColor = currentUIColor.adjusted(byPercentage: percentage)
        return Color(adjustedUIColor)
    }
}

// Copyright © 2021 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

public struct NavigationHidden: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

public extension View {
    func navigationHidden() -> some View {
        self.modifier(NavigationHidden())
    }
}

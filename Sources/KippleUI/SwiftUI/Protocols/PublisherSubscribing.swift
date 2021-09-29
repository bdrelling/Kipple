// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import KippleCore

public protocol PublisherSubscribing: ObservableObject {
    var subscriptions: Set<AnyCancellable> { get set }

    func subscribeToPublishers()
    func unsubscribeFromPublishers()
}

public extension PublisherSubscribing {
    func onAppear() {
        guard !Kipple.isRunningInXcodePreview else {
            return
        }

        self.subscribeToPublishers()
    }

    func onDisappear() {
        self.unsubscribeFromPublishers()
    }

    func unsubscribeFromPublishers() {
        self.subscriptions = []
    }
}

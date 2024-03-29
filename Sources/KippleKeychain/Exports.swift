// Copyright © 2024 Brian Drelling. All rights reserved.

// This files declares globally exported modules, which are then implicitly imported alongside this module whenever it is imported.
//
// NOTE: APIs with the _ prefix are considered to be unfinalized, so the signature of the attribute is subject to change.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

@_exported import KeychainAccess

#endif

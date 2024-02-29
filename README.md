# Kipple

[![CI Status](https://github.com/bdrelling/Kipple/actions/workflows/tests.yml/badge.svg)](https://github.com/bdrelling/Kipple/actions/workflows/tests.yml)
[![Latest Release](https://img.shields.io/github/v/tag/bdrelling/Kipple?color=blue&label=)](https://github.com/bdrelling/Kipple/tags)
[![Swift Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKipple%2Fbadge%3Ftype%3Dswift-versions&label=)](https://swiftpackageindex.com/bdrelling/Kipple)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKipple%2Fbadge%3Ftype%3Dplatforms&label=)](https://swiftpackageindex.com/bdrelling/Kipple)
[![License](https://img.shields.io/github/license/bdrelling/Kipple?label=)](https://github.com/bdrelling/Kipple/blob/main/LICENSE)

**Kipple** is a collection of Swift modules providing common Swift functionality for rapid prototyping, quick reference, education, discovery, and personal use, covering concepts from logging to error handling to running Swift excutables and more.

> [!WARNING]
> The code in this library has been made public as-is solely for the purposes of reference, education, discovery, and personal use. As such, stability for production applications **CANNOT** be guaranteed; however, if you're interested in leveraging code within this library in your own projects, feel free to do so at your own risk.
>
> Please open GitHub issues for any problems you encounter or requests you have and we will do my best to provide support.

## Table of Contents

- [Documentation](#documentation)
- [Communication](#communication)
- [Installation](#installation)
- [External Dependencies](#external-dependencies)
- [Component Libraries](#component-libraries)
- [Maintenance](#maintenance)
- [Compatibility](#compatibility)
- [Stability](#stability)
- [Contributing](#contributing)
- [FAQ](#faq)
- [License](#license)

## Documentation

TODO: Update this section

- [Kipple](/Sources/Kipple) — An umbrella module that implicitly imports all other modules.
- [KippleCodable](/KippleCodable) — Provides convenience functionality based around the `Codable` protocol.
- [KippleCollections](/KippleCollections) — Provides convenience extensions for `Collections`. Additionally, it imports the `OrderedCollections` module of `swift-collections`.
- [KippleCombine](/KippleCombine) — TBD
- [KippleCore](/KippleCore) — TBD
- [KippleDevice](/KippleDevice) — TBD
- [KippleKeychain](/KippleKeychain) — TBD
- [KippleLocalStorage](/KippleLocalStorage) — TBD
- [KippleLogging](/KippleLogging) — TBD

## Installation

### Swift Package Manager (SPM)

> [!WARNING]
> Please read the [Stability](#stability) section before considering this installation method.

[Swift Package Manager (SPM)](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Swift Package Manager is included in Swift 3.0 and above.

### Manual

Alternatively, feel free to copy any module, file, or line of code into your own Swift project!

**Kipple** is released under the MIT license. See [LICENSE](LICENSE) for details.

## External Dependencies

TODO: Update this section

## Component Libraries

To keep **Kipple** focused on core functionality, there are additional components that live in external packages. Each package provides functionality around a more complex topic, such as Networking or UI, which most applications don't need.

Each package essentially does what it says on the tin — check out their respective READMEs for more information!

| Package | Tests | Version | Swift | Platforms |
| ------- | ----- | ------- | ----- | --------- |
| [KippleNetworking](https://github.com/bdrelling/KippleNetworking) | [![](https://img.shields.io/github/actions/workflow/status/bdrelling/KippleNetworking/tests.yml?branch=main&label=)](https://github.com/bdrelling/KippleNetworking/actions/workflows/tests.yml) | [![](https://img.shields.io/github/v/tag/bdrelling/KippleNetworking?color=blue&label=)](https://github.com/bdrelling/KippleNetworking/tags) | [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleNetworking%2Fbadge%3Ftype%3Dswift-versions&label=)](https://swiftpackageindex.com/bdrelling/KippleNetworking) |  [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleNetworking%2Fbadge%3Ftype%3Dplatforms&label=)](https://swiftpackageindex.com/bdrelling/KippleNetworking) |
| [KipplePlugins](https://github.com/bdrelling/KipplePlugins) | [![](https://img.shields.io/github/actions/workflow/status/bdrelling/KipplePlugins/tests.yml?branch=main&label=)](https://github.com/bdrelling/KipplePlugins/actions/workflows/tests.yml) | [![](https://img.shields.io/github/v/tag/bdrelling/KipplePlugins?color=blue&label=)](https://github.com/bdrelling/KipplePlugins/tags) | [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKipplePlugins%2Fbadge%3Ftype%3Dswift-versions&label=)](https://swiftpackageindex.com/bdrelling/KipplePlugins) |  [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKipplePlugins%2Fbadge%3Ftype%3Dplatforms&label=)](https://swiftpackageindex.com/bdrelling/KipplePlugins) |
| [KippleTools](https://github.com/bdrelling/KippleTools) | [![](https://img.shields.io/github/actions/workflow/status/bdrelling/KippleTools/tests.yml?branch=main&label=)](https://github.com/bdrelling/KippleTools/actions/workflows/tests.yml) | [![](https://img.shields.io/github/v/tag/bdrelling/KippleTools?color=blue&label=)](https://github.com/bdrelling/KippleTools/tags) | [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleTools%2Fbadge%3Ftype%3Dswift-versions&label=)](https://swiftpackageindex.com/bdrelling/KippleTools) |  [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleTools%2Fbadge%3Ftype%3Dplatforms&label=)](https://swiftpackageindex.com/bdrelling/KippleTools) |
| [KippleUI](https://github.com/bdrelling/KippleUI) | [![](https://img.shields.io/github/actions/workflow/status/bdrelling/KippleUI/tests.yml?branch=main&label=)](https://github.com/bdrelling/KippleUI/actions/workflows/tests.yml) | [![](https://img.shields.io/github/v/tag/bdrelling/KippleUI?color=blue&label=)](https://github.com/bdrelling/KippleUI/tags) | [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleUI%2Fbadge%3Ftype%3Dswift-versions&label=)](https://swiftpackageindex.com/bdrelling/KippleUI) |  [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleUI%2Fbadge%3Ftype%3Dplatforms&label=)](https://swiftpackageindex.com/bdrelling/KippleUI) |

## Maintenance

Kipple is **inactively maintained**, meaning that updates are made to the packages above as needed, whether to squash bugs, remove outdated content, update Swift and platform compatibilities, or include new content for educational purposes.

Additionally, I will make an effort to address any and all Issues and Pull Requests that are opened into my repository as thanks for your help in improving the stability for these packages and therefore my own (and others') applications. **If you don't receive a timely response from me on an Issue or Pull Request**, please don't hesitate to ping me again.

## Compatibility

**Swift Versions**: Packages will always support a minimum of all versions of Swift bundled with the two most recent major versions of Xcode. (Example: At time of writing, Xcode 15.2 is currently out, so Kipple supports Xcode 14.0 and up, which means that Swift 5.7 is the minimum version for all packages.) See [swiftversion.net](https://swiftversion.net/) for a reference of Swift and Xcode versions.

**Platforms**: All packages are meant to be platform-agnostic and run everywhere that Swift can run, with few exceptions such as a package like [KippleUI](https://github.com/bdrelling/KippleUI) which is closely tied to Apple platform SDKs (SwiftUI, UIKit, AppKit, etc.), so there is no consideration for Linux, Windows, or Android and the packages will fail to build on those platforms. For new and emerging platforms (such as visionOS with Xcode 15), Kipple packages may not be supported until the following Xcode major version release.

**Platform Versions**: Similarly to Swift Version support, minimum versions of all platforms are dictated by the SDKs introduced with the two most recent major versions of Xcode. (Example: At time of writing, Xcode 15.2 is currently out, so Kipple supports iOS 16.0+, macOS 13.0+, watchOS 9.0+, tvOS 16.0+, and Linux.) See [xcodereleases.com](https://xcodesreleases.com/) for a reference of Xcode versions and their bundled SDKs.

**Package Managers**: Given that these projects are largely for reference and education and not intended to be directly depended upon, Kipple packages only support [Swift Package Manager](https://github.com/apple/swift-package-manager) for ease of maintenance.

## Stability

Every repository in this organization includes the following disclaimer:

> [!WARNING]
> The code in this library has been made public as-is solely for the purposes of reference, education, discovery, and personal use. As such, stability for production applications **CANNOT** be guaranteed; however, if you're interested in leveraging code within this library in your own projects, feel free to do so at your own risk.
>
> Please open GitHub issues for any problems you encounter or requests you have and we will do my best to provide support.

An important note to package maintainers: **Please do not include these packages as a dependency of your own packages!** Doing so can introduce transitive risk to your consumers, who may not have opted into using unstable packages such as these.

That said, I use all of these repositories in numerous applications and projects myself, many of them in production. I also leverage two CI reports (GitHub Actions and Swift Package Index) and try my best to cover core functionality with tests as much as possible.

## Contributing

Feel free to open GitHub Issues or Pull Requests for any problems you encounter or requests you have.

## FAQ

### What does "Kipple" mean?

The concept of "**Kipple**" comes from the [Philip K. Dick](https://en.wikipedia.org/wiki/Philip_K._Dick) book [Do Androids Dream of Electric Sheep?](https://en.wikipedia.org/wiki/Do_Androids_Dream_of_Electric_Sheep%3F).

> **Kipple** is useless objects, like junk mail or match folders after you use the last match or gum wrappers of yesterday's homeopape. **When nobody's around, kipple reproduces itself.** For instance, if you go to bed leaving any kipple around your apartment, when you wake up the next morning there's twice as much of it. It always gets more and more.
>
> No one can win against kipple, except temporarily and maybe in one spot,[...] It's a universal principle operating throughout the universe; the entire universe is moving toward a final state of total, absolute kippleization.

With every new project, developers write a lot of the same boilerplate code again and again, which piles up quickly. It's not _useless_ code, per se, but it's usually fairly trivial solutions repeated over and over per-project that never _quite_ warrant pulling in bloated third-party dependencies, but can be a burden to recreate time and time again.

## License

**Kipple** is released under the MIT license. See [LICENSE](LICENSE) for details.

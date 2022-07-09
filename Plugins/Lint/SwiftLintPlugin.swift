// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import PackagePlugin

@main
struct SwiftLintPlugin {
    private func perform(
        swiftformat: PluginContext.Tool,
        defaultSwiftVersion: String,
        arguments: [String],
        targetPaths: ([String]) throws -> [String]
    ) throws {}
}

extension SwiftLintPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) throws {
        let tool = try context.tool(named: "swiftlint")
        let toolUrl = URL(fileURLWithPath: tool.path.string)

        for target in context.package.targets {
            guard let target = target as? SourceModuleTarget else { continue }

            let process = Process()
            process.executableURL = toolUrl
            process.arguments = [
                "\(target.directory)",
                "--fix",
            ]

            print(toolUrl.path, process.arguments!.joined(separator: " "))

            try process.run()
            process.waitUntilExit()
        }
    }
}

#if canImport(XcodeProjectPlugin)
    import XcodeProjectPlugin

    extension SwiftLintPlugin: XcodeCommandPlugin {
        func performCommand(context: XcodePluginContext, arguments: [String]) throws {}
    }
#endif

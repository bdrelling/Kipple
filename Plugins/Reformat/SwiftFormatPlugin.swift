// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import PackagePlugin

@main
struct SwiftFormatPlugin {
    private func perform(
        swiftformat: PluginContext.Tool,
        defaultSwiftVersion: String,
        arguments: [String],
        targetPaths: ([String]) throws -> [String]
    ) throws {
        var argumentExtractor = ArgumentExtractor(arguments)

        let swiftVersion: String
        if let version = argumentExtractor.extractOption(named: "swiftversion").first {
            swiftVersion = version
        } else {
            swiftVersion = defaultSwiftVersion
        }

        let targetNames = argumentExtractor.extractOption(named: "target")
        let targets = try targetPaths(targetNames)

        let fileURL = URL(fileURLWithPath: swiftformat.path.string)
        let process = Process()
        process.executableURL = fileURL
        process.arguments = (!targets.isEmpty ? targets : ["."]) +
            ["--swiftversion", swiftVersion] +
            argumentExtractor.remainingArguments

        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        try process.run()
        process.waitUntilExit()
    }
}

extension SwiftFormatPlugin: CommandPlugin {
    func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
        let toolsVersion = context.package.toolsVersion
        let swiftVersion = "\(toolsVersion.major).\(toolsVersion.minor).\(toolsVersion.patch)"

        try self.perform(
            swiftformat: try context.tool(named: "swiftformat"),
            defaultSwiftVersion: swiftVersion,
            arguments: arguments
        ) { targets in
            try context.package.targets(named: targets).map(\.directory.string)
        }
    }
}

#if canImport(XcodeProjectPlugin)
    import XcodeProjectPlugin

    extension SwiftFormatPlugin: XcodeCommandPlugin {
        func performCommand(context: XcodePluginContext, arguments: [String]) throws {
            try self.perform(
                swiftformat: try context.tool(named: "swiftformat"),
                defaultSwiftVersion: "5.7",
                arguments: arguments
            ) { targetNames in
                // It is impossible to provide directories like in Swift Package case
                // because input files in XcodeTarget aren't restricted by a directory.
                let targets = context.xcodeProject.targets.filter { targetNames.contains($0.displayName) }
                return targets.flatMap(\.inputFiles).map(\.path.string)
            }
        }
    }
#endif

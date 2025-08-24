//
//  ModernDesignSystemPlugin.swift
//  ModernDesignSystem
//
//  Created by Kamil Kowalski on 19/08/2025.
//  Copyright © 2025 Kamil Kowalski. All rights reserved.
//
//  This file is part of ModernDesignSystem.
//
//  ModernDesignSystem is free software: you can redistribute it and/or modify
//  it under the terms of the MIT License as published in the LICENSE file.
//
//  ModernDesignSystem is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  MIT License for more details.
//

import Foundation
import PackagePlugin

@main
struct ModernDesignSystemPlugin: CommandPlugin {
    func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
        guard let target = context.package.targets.first(where: { $0.name == "ModernDesignSystem" }) as? SwiftSourceModuleTarget else {
            Diagnostics.error("Target not found")
            return
        }
        
        guard let assets = target.sourceFiles(withSuffix: "xcassets").first else {
            Diagnostics.error("Assets not found")
            return
        }
        
        let outputPath = target.directoryURL.appending(component: "Assets.swift")
        
        guard let tool = try? context.tool(named: "MapAssets") else { return }
        let toolURL = tool.url
        
        let process = Process()
        process.executableURL = toolURL
        process.arguments = [assets.url.path(), outputPath.path()]
        process.environment = nil
        
        try process.run()
        process.waitUntilExit()

        if process.terminationReason == .exit, process.terminationStatus == 0 {
            print("Successfully created Assets.swift file.")
        } else {
            let problem = "\(process.terminationReason):\(process.terminationStatus)"
            Diagnostics.error("MapAssets invocation failed: \(problem)")
        }
    }
}
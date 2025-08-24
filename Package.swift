// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Package.swift
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

import PackageDescription

let package = Package(
    name: "ModernDesignSystem",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "ModernDesignSystem",
            targets: ["ModernDesignSystem"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ModernDesignSystem",
            resources: [.process("Resources/ModernDesignSystemAssets.xcassets")]
        ),
        .executableTarget(
            name: "MapAssets"
        ),
        .plugin(
            name: "ModernDesignSystemPlugin",
            capability: .command(
                intent: .custom(
                    verb: "generate-moderndesignsystem-assets",
                    description: "This plugin generates Assets file for modern design system."
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Needs access to package directory to generate Assets.swift file.")
                ]
            ),
            dependencies: ["MapAssets"]
        ),
        .testTarget(
            name: "ModernDesignSystemTests",
            dependencies: ["ModernDesignSystem"]
        )
    ]
)
//
//  ModernDesignSystemExampleApp.swift
//  ModernDesignSystemExample
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

import SwiftUI
import ModernDesignSystem

@main
struct ModernDesignSystemExampleApp: App {
    @MainActor @StateObject private var designSystem = ModernDesignSystem.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(designSystem)
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
        #endif
    }
}
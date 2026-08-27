//
//  EnvironmentValues.swift
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

// MARK: - Dependency injection
//
// `ModernDesignSystem` is injected through the SwiftUI environment as an
// `ObservableObject`. Provide it once near the root with
// `.environmentObject(ModernDesignSystem.shared)` (or your own instance); every
// component reads it via `@EnvironmentObject var designSystem: ModernDesignSystem`
// and re-renders reactively when its `@Published` state changes.
//
// A previous `EnvironmentValues.modernDesignSystem` key and
// `.modernDesignSystem(_:)` modifier were removed: they were incompatible with
// the `@EnvironmentObject`-based components (using the modifier crashed every
// component at runtime) and an `ObservableObject` stored as a plain environment
// value would not have driven view updates.

//
//  ModernDesignSystem.swift
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

import Combine
import SwiftUI

public final class ModernDesignSystem: ObservableObject {
    @AppStorage("useSystemTheme") public var useSystemTheme = true {
        didSet { objectWillChange.send() }
    }
    @AppStorage("currentTheme") public var theme: Theme = .light {
        didSet { objectWillChange.send() }
    }
    @AppStorage("selectedColorSet") public var selectedColorSet: ColorSetName = .modernBlue {
        didSet { objectWillChange.send() }
    }
    
    @Published public var designFoundations: DesignFoundations
    @Published public var brand: Brand
    @Published public var brands: [Brand]
    
    private var cancellables: [AnyCancellable] = []
    
    public init(brands: [Brand], designFoundations: DesignFoundations) {
        precondition(!brands.isEmpty, "Brands cannot be empty")
        self.designFoundations = designFoundations
        self.brands = brands
        self.brand = brands[0]
        if !brand.themes.contains(theme) {
            precondition(!brand.themes.isEmpty, "Themes cannot be empty")
            self.theme = brand.themes[0]
        }
    }
    
    public convenience init(brand: Brand, designFoundations: DesignFoundations = .modern) {
        self.init(brands: [brand], designFoundations: designFoundations)
    }
    
    public func updateFoundations(_ designFoundations: DesignFoundations) {
        self.designFoundations = designFoundations
    }
    
    public func currentTheme(with systemScheme: ColorScheme, forceSystem: Bool = false) -> Theme {
        if forceSystem || useSystemTheme {
            brand.systemThemeMapping.theme(systemScheme)
        } else {
            theme
        }
    }
    
    public func currentScheme(with systemScheme: ColorScheme, forceSystem: Bool = false) -> ColorScheme {
        if forceSystem || useSystemTheme {
            systemScheme
        } else {
            theme.system
        }
    }
    
    public func color(_ path: ColorPath?, systemScheme: ColorScheme, forceSystem: Bool = false) -> Color {
        guard let path else { return .white.opacity(0.0000001) }
        
        let semanticColorToken = brand.semanticColors[keyPath: path]
        let globalColorPath = semanticColorToken[currentTheme(with: systemScheme, forceSystem: forceSystem)]
        return designFoundations.globalColors[keyPath: globalColorPath].color
    }
    
    public func colorToken(_ path: ColorPath?, systemScheme: ColorScheme, forceSystem: Bool = false) -> ColorToken {
        guard let path else { return .init(red: 0, green: 0, blue: 0, opacity: 0.0000001) }
        
        let semanticColorToken = brand.semanticColors[keyPath: path]
        let globalColorPath = semanticColorToken[currentTheme(with: systemScheme, forceSystem: forceSystem)]
        return designFoundations.globalColors[keyPath: globalColorPath]
    }
    
    public func font(_ path: FontPath,
                     verticalSizeClass: UserInterfaceSizeClass?,
                     horizontalSizeClass: UserInterfaceSizeClass?) -> Font {
        brand.typography[keyPath: path].font(verticalSizeClass: verticalSizeClass, horizontalSizeClass: horizontalSizeClass)
    }
    
    // Color set management inspired by IceCubesApp
    public var currentColorSet: ColorSet {
        availableColorSets.first { $0.name == selectedColorSet } ?? modernBlueColorSet
    }
    
    public func applyColorSet(_ colorSet: ColorSet) {
        selectedColorSet = colorSet.name
        objectWillChange.send()
    }
}

// MARK: - Default instances
public extension ModernDesignSystem {
    @MainActor
    static let shared = ModernDesignSystem(brand: .modern)
}
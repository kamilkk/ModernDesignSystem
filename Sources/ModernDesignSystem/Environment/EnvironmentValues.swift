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

import SwiftUI

// MARK: - Design System Environment Key

public struct ModernDesignSystemKey: EnvironmentKey {
  public nonisolated(unsafe) static let defaultValue: ModernDesignSystem = {
    let brand = Brand(
      name: "Modern",
      themes: [.light, .dark],
      systemThemeMapping: SystemThemeMapping(light: .light, dark: .dark),
      semanticColors: SemanticColors(
        primaryBackground: SemanticColorToken(light: \.neutral100, dark: \.neutral900),
        secondaryBackground: SemanticColorToken(light: \.neutral200, dark: \.neutral800),
        tertiaryBackground: SemanticColorToken(light: \.neutral300, dark: \.neutral700),
        primaryText: SemanticColorToken(light: \.neutral900, dark: \.neutral100),
        secondaryText: SemanticColorToken(light: \.neutral700, dark: \.neutral300),
        tertiaryText: SemanticColorToken(light: \.neutral600, dark: \.neutral400),
        quaternaryText: SemanticColorToken(light: \.neutral500, dark: \.neutral500),
        primary: SemanticColorToken(light: \.primary500, dark: \.primary400),
        secondary: SemanticColorToken(light: \.secondary500, dark: \.secondary400),
        accent: SemanticColorToken(light: \.primary600, dark: \.primary300),
        success: SemanticColorToken(light: \.success500, dark: \.success400),
        warning: SemanticColorToken(light: \.warning500, dark: \.warning400),
        error: SemanticColorToken(light: \.error500, dark: \.error400),
        info: SemanticColorToken(light: \.primary500, dark: \.primary400),
        primaryBorder: SemanticColorToken(light: \.neutral400, dark: \.neutral600),
        secondaryBorder: SemanticColorToken(light: \.neutral300, dark: \.neutral700)
      ),
      spacing: Spacing(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48, xxxl: 64),
      elevation: Elevation(
        none: ElevationToken(shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0), shadowRadius: 0, shadowOffset: CGSize(width: 0, height: 0), shadowOpacity: 0),
        xs: ElevationToken(shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.1), shadowRadius: 2, shadowOffset: CGSize(width: 0, height: 1), shadowOpacity: 0.1),
        sm: ElevationToken(shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.1), shadowRadius: 4, shadowOffset: CGSize(width: 0, height: 2), shadowOpacity: 0.1),
        md: ElevationToken(shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.15), shadowRadius: 8, shadowOffset: CGSize(width: 0, height: 4), shadowOpacity: 0.15),
        lg: ElevationToken(shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.2), shadowRadius: 16, shadowOffset: CGSize(width: 0, height: 8), shadowOpacity: 0.2),
        xl: ElevationToken(shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.25), shadowRadius: 24, shadowOffset: CGSize(width: 0, height: 12), shadowOpacity: 0.25),
        xxl: ElevationToken(shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.3), shadowRadius: 32, shadowOffset: CGSize(width: 0, height: 16), shadowOpacity: 0.3)
      ),
      typography: FontTokens(
        displayLarge: FontToken(size: 57, weight: .regular, lineHeight: 64),
        displayMedium: FontToken(size: 45, weight: .regular, lineHeight: 52),
        displaySmall: FontToken(size: 36, weight: .regular, lineHeight: 44),
        headlineLarge: FontToken(size: 32, weight: .regular, lineHeight: 40),
        headlineMedium: FontToken(size: 28, weight: .regular, lineHeight: 36),
        headlineSmall: FontToken(size: 24, weight: .regular, lineHeight: 32),
        titleLarge: FontToken(size: 22, weight: .regular, lineHeight: 28),
        titleMedium: FontToken(size: 16, weight: .medium, lineHeight: 24),
        titleSmall: FontToken(size: 14, weight: .medium, lineHeight: 20),
        labelLarge: FontToken(size: 14, weight: .medium, lineHeight: 20),
        labelMedium: FontToken(size: 12, weight: .medium, lineHeight: 16),
        labelSmall: FontToken(size: 11, weight: .medium, lineHeight: 16),
        bodyLarge: FontToken(size: 16, weight: .regular, lineHeight: 24),
        bodyMedium: FontToken(size: 14, weight: .regular, lineHeight: 20),
        bodySmall: FontToken(size: 12, weight: .regular, lineHeight: 16),
        captionLarge: FontToken(size: 12, weight: .regular, lineHeight: 16),
        captionMedium: FontToken(size: 11, weight: .regular, lineHeight: 16),
        captionSmall: FontToken(size: 10, weight: .regular, lineHeight: 14)
      )
    )
    return ModernDesignSystem(brand: brand)
  }()
}

public extension EnvironmentValues {
  var modernDesignSystem: ModernDesignSystem {
    get { self[ModernDesignSystemKey.self] }
    set { self[ModernDesignSystemKey.self] = newValue }
  }
}

// MARK: - View Extensions

public extension View {
  func modernDesignSystem(_ designSystem: ModernDesignSystem) -> some View {
    environment(\.modernDesignSystem, designSystem)
  }
}

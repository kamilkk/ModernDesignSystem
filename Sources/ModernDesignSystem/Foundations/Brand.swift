//
//  Brand.swift
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

public struct Brand: Hashable {
  public let name: String
  public let themes: [Theme]
  public let systemThemeMapping: SystemThemeMapping
  public let semanticColors: SemanticColors
  public let spacing: Spacing
  public let elevation: Elevation
  public let typography: FontTokens

  public init(
    name: String,
    themes: [Theme],
    systemThemeMapping: SystemThemeMapping,
    semanticColors: SemanticColors,
    spacing: Spacing,
    elevation: Elevation,
    typography: FontTokens
  ) {
    self.name = name
    self.themes = themes
    self.systemThemeMapping = systemThemeMapping
    self.semanticColors = semanticColors
    self.spacing = spacing
    self.elevation = elevation
    self.typography = typography
  }
}

// MARK: - Default Brand

public extension Brand {
  nonisolated(unsafe) static let modern = Brand(
    name: "Modern",
    themes: [.light, .dark],
    systemThemeMapping: .default,
    semanticColors: .modern,
    spacing: .modern,
    elevation: .modern,
    typography: .modern
  )
}

// MARK: - Default Semantic Colors

public extension SemanticColors {
  nonisolated(unsafe) static let modern = SemanticColors(
    primaryBackground: SemanticColorToken(
      light: \.neutral100,
      dark: \.neutral900
    ),
    secondaryBackground: SemanticColorToken(
      light: \.neutral200,
      dark: \.neutral800
    ),
    tertiaryBackground: SemanticColorToken(
      light: \.neutral300,
      dark: \.neutral700
    ),
    primaryText: SemanticColorToken(
      light: \.neutral900,
      dark: \.neutral100
    ),
    secondaryText: SemanticColorToken(
      light: \.neutral700,
      dark: \.neutral300
    ),
    tertiaryText: SemanticColorToken(
      light: \.neutral600,
      dark: \.neutral400
    ),
    quaternaryText: SemanticColorToken(
      light: \.neutral500,
      dark: \.neutral500
    ),
    primary: SemanticColorToken(
      light: \.primary500,
      dark: \.primary400
    ),
    secondary: SemanticColorToken(
      light: \.secondary500,
      dark: \.secondary400
    ),
    accent: SemanticColorToken(
      light: \.primary600,
      dark: \.primary300
    ),
    success: SemanticColorToken(
      light: \.success500,
      dark: \.success400
    ),
    warning: SemanticColorToken(
      light: \.warning500,
      dark: \.warning400
    ),
    error: SemanticColorToken(
      light: \.error500,
      dark: \.error400
    ),
    info: SemanticColorToken(
      light: \.primary500,
      dark: \.primary400
    ),
    primaryBorder: SemanticColorToken(
      light: \.neutral400,
      dark: \.neutral600
    ),
    secondaryBorder: SemanticColorToken(
      light: \.neutral300,
      dark: \.neutral700
    )
  )
}

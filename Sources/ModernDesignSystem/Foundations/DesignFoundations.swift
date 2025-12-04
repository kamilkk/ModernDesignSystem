//
//  DesignFoundations.swift
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

public struct DesignFoundations: Codable, Hashable, Sendable {
  public let name: String
  public let globalColors: GlobalColors

  public init(name: String, globalColors: GlobalColors) {
    self.name = name
    self.globalColors = globalColors
  }
}

// MARK: - Default Design Foundations

public extension DesignFoundations {
  static let modern = DesignFoundations(
    name: "Modern",
    globalColors: .modern
  )
}

// MARK: - Default Global Colors

public extension GlobalColors {
  static let modern = GlobalColors(
    // Primary colors (Modern Blue)
    primary100: ColorToken(red: 0.9, green: 0.95, blue: 1.0),
    primary200: ColorToken(red: 0.8, green: 0.9, blue: 1.0),
    primary300: ColorToken(red: 0.6, green: 0.8, blue: 1.0),
    primary400: ColorToken(red: 0.4, green: 0.7, blue: 1.0),
    primary500: ColorToken(red: 0.0, green: 0.48, blue: 1.0),
    primary600: ColorToken(red: 0.0, green: 0.38, blue: 0.8),
    primary700: ColorToken(red: 0.0, green: 0.28, blue: 0.6),
    primary800: ColorToken(red: 0.0, green: 0.18, blue: 0.4),
    primary900: ColorToken(red: 0.0, green: 0.08, blue: 0.2),

    // Secondary colors (Neutral Gray)
    secondary100: ColorToken(red: 0.98, green: 0.98, blue: 0.98),
    secondary200: ColorToken(red: 0.95, green: 0.95, blue: 0.95),
    secondary300: ColorToken(red: 0.9, green: 0.9, blue: 0.9),
    secondary400: ColorToken(red: 0.8, green: 0.8, blue: 0.8),
    secondary500: ColorToken(red: 0.6, green: 0.6, blue: 0.6),
    secondary600: ColorToken(red: 0.4, green: 0.4, blue: 0.4),
    secondary700: ColorToken(red: 0.3, green: 0.3, blue: 0.3),
    secondary800: ColorToken(red: 0.2, green: 0.2, blue: 0.2),
    secondary900: ColorToken(red: 0.1, green: 0.1, blue: 0.1),

    // Neutral colors (True Neutral)
    neutral100: ColorToken(red: 1.0, green: 1.0, blue: 1.0),
    neutral200: ColorToken(red: 0.98, green: 0.98, blue: 0.98),
    neutral300: ColorToken(red: 0.94, green: 0.94, blue: 0.94),
    neutral400: ColorToken(red: 0.86, green: 0.86, blue: 0.86),
    neutral500: ColorToken(red: 0.74, green: 0.74, blue: 0.74),
    neutral600: ColorToken(red: 0.52, green: 0.52, blue: 0.52),
    neutral700: ColorToken(red: 0.4, green: 0.4, blue: 0.4),
    neutral800: ColorToken(red: 0.26, green: 0.26, blue: 0.26),
    neutral900: ColorToken(red: 0.09, green: 0.09, blue: 0.09),

    // Success colors (Green)
    success100: ColorToken(red: 0.9, green: 0.98, blue: 0.9),
    success200: ColorToken(red: 0.8, green: 0.95, blue: 0.8),
    success300: ColorToken(red: 0.6, green: 0.9, blue: 0.6),
    success400: ColorToken(red: 0.4, green: 0.8, blue: 0.4),
    success500: ColorToken(red: 0.13, green: 0.55, blue: 0.13),
    success600: ColorToken(red: 0.1, green: 0.45, blue: 0.1),
    success700: ColorToken(red: 0.08, green: 0.35, blue: 0.08),
    success800: ColorToken(red: 0.05, green: 0.25, blue: 0.05),
    success900: ColorToken(red: 0.02, green: 0.15, blue: 0.02),

    // Warning colors (Orange)
    warning100: ColorToken(red: 1.0, green: 0.98, blue: 0.9),
    warning200: ColorToken(red: 1.0, green: 0.95, blue: 0.8),
    warning300: ColorToken(red: 1.0, green: 0.9, blue: 0.6),
    warning400: ColorToken(red: 1.0, green: 0.8, blue: 0.4),
    warning500: ColorToken(red: 1.0, green: 0.6, blue: 0.0),
    warning600: ColorToken(red: 0.9, green: 0.5, blue: 0.0),
    warning700: ColorToken(red: 0.8, green: 0.4, blue: 0.0),
    warning800: ColorToken(red: 0.6, green: 0.3, blue: 0.0),
    warning900: ColorToken(red: 0.4, green: 0.2, blue: 0.0),

    // Error colors (Red)
    error100: ColorToken(red: 1.0, green: 0.9, blue: 0.9),
    error200: ColorToken(red: 1.0, green: 0.8, blue: 0.8),
    error300: ColorToken(red: 1.0, green: 0.6, blue: 0.6),
    error400: ColorToken(red: 1.0, green: 0.4, blue: 0.4),
    error500: ColorToken(red: 0.9, green: 0.2, blue: 0.2),
    error600: ColorToken(red: 0.8, green: 0.1, blue: 0.1),
    error700: ColorToken(red: 0.7, green: 0.05, blue: 0.05),
    error800: ColorToken(red: 0.6, green: 0.0, blue: 0.0),
    error900: ColorToken(red: 0.4, green: 0.0, blue: 0.0)
  )
}

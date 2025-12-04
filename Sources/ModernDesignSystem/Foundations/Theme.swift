//
//  Theme.swift
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

public enum Theme: String, CaseIterable, Codable, Sendable {
  case light
  case dark

  public var system: ColorScheme {
    switch self {
    case .light:
      return .light
    case .dark:
      return .dark
    }
  }

  public var name: String {
    switch self {
    case .light:
      return "Light"
    case .dark:
      return "Dark"
    }
  }
}

public struct SystemThemeMapping: Codable, Hashable, Sendable {
  public let light: Theme
  public let dark: Theme

  public init(light: Theme, dark: Theme) {
    self.light = light
    self.dark = dark
  }

  public func theme(_ colorScheme: ColorScheme) -> Theme {
    switch colorScheme {
    case .light:
      return light
    case .dark:
      return dark
    @unknown default:
      return light
    }
  }
}

// MARK: - Default mappings

public extension SystemThemeMapping {
  static let `default` = SystemThemeMapping(light: .light, dark: .dark)
}

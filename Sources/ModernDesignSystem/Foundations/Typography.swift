//
//  Typography.swift
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

public struct FontToken: Codable, Hashable, Sendable {
  public let size: CGFloat
  public let weight: FontWeight
  public let lineHeight: CGFloat?
  public let letterSpacing: CGFloat?

  public init(size: CGFloat, weight: FontWeight, lineHeight: CGFloat? = nil, letterSpacing: CGFloat? = nil) {
    self.size = size
    self.weight = weight
    self.lineHeight = lineHeight
    self.letterSpacing = letterSpacing
  }

  public func font(verticalSizeClass: UserInterfaceSizeClass?, horizontalSizeClass: UserInterfaceSizeClass?) -> Font {
    let scaleFactor: CGFloat = {
      switch (verticalSizeClass, horizontalSizeClass) {
      case (.compact, _):
        return 0.9
      case (_, .compact):
        return 0.95
      default:
        return 1.0
      }
    }()

    return Font.system(size: size * scaleFactor, weight: weight.swiftUIWeight)
  }
}

public enum FontWeight: String, Codable, CaseIterable, Sendable {
  case ultraLight
  case thin
  case light
  case regular
  case medium
  case semibold
  case bold
  case heavy
  case black

  public var swiftUIWeight: Font.Weight {
    switch self {
    case .ultraLight:
      return .ultraLight
    case .thin:
      return .thin
    case .light:
      return .light
    case .regular:
      return .regular
    case .medium:
      return .medium
    case .semibold:
      return .semibold
    case .bold:
      return .bold
    case .heavy:
      return .heavy
    case .black:
      return .black
    }
  }
}

public struct FontTokens: Codable, Hashable, Sendable {
  // Display typography
  public let displayLarge: FontToken
  public let displayMedium: FontToken
  public let displaySmall: FontToken

  // Headline typography
  public let headlineLarge: FontToken
  public let headlineMedium: FontToken
  public let headlineSmall: FontToken

  // Title typography
  public let titleLarge: FontToken
  public let titleMedium: FontToken
  public let titleSmall: FontToken

  // Label typography
  public let labelLarge: FontToken
  public let labelMedium: FontToken
  public let labelSmall: FontToken

  // Body typography
  public let bodyLarge: FontToken
  public let bodyMedium: FontToken
  public let bodySmall: FontToken

  // Caption typography
  public let captionLarge: FontToken
  public let captionMedium: FontToken
  public let captionSmall: FontToken

  public init(
    displayLarge: FontToken,
    displayMedium: FontToken,
    displaySmall: FontToken,
    headlineLarge: FontToken,
    headlineMedium: FontToken,
    headlineSmall: FontToken,
    titleLarge: FontToken,
    titleMedium: FontToken,
    titleSmall: FontToken,
    labelLarge: FontToken,
    labelMedium: FontToken,
    labelSmall: FontToken,
    bodyLarge: FontToken,
    bodyMedium: FontToken,
    bodySmall: FontToken,
    captionLarge: FontToken,
    captionMedium: FontToken,
    captionSmall: FontToken
  ) {
    self.displayLarge = displayLarge
    self.displayMedium = displayMedium
    self.displaySmall = displaySmall
    self.headlineLarge = headlineLarge
    self.headlineMedium = headlineMedium
    self.headlineSmall = headlineSmall
    self.titleLarge = titleLarge
    self.titleMedium = titleMedium
    self.titleSmall = titleSmall
    self.labelLarge = labelLarge
    self.labelMedium = labelMedium
    self.labelSmall = labelSmall
    self.bodyLarge = bodyLarge
    self.bodyMedium = bodyMedium
    self.bodySmall = bodySmall
    self.captionLarge = captionLarge
    self.captionMedium = captionMedium
    self.captionSmall = captionSmall
  }
}

public typealias FontPath = KeyPath<FontTokens, FontToken>

// MARK: - Default Font Tokens

public extension FontTokens {
  static let modern = FontTokens(
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
}

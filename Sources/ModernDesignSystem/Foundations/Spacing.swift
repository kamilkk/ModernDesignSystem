//
//  Spacing.swift
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

public struct Spacing: Codable, Hashable, Sendable {
  public let xs: CGFloat
  public let sm: CGFloat
  public let md: CGFloat
  public let lg: CGFloat
  public let xl: CGFloat
  public let xxl: CGFloat
  public let xxxl: CGFloat

  public init(xs: CGFloat, sm: CGFloat, md: CGFloat, lg: CGFloat, xl: CGFloat, xxl: CGFloat, xxxl: CGFloat) {
    self.xs = xs
    self.sm = sm
    self.md = md
    self.lg = lg
    self.xl = xl
    self.xxl = xxl
    self.xxxl = xxxl
  }
}

// MARK: - Default Spacing

public extension Spacing {
  static let modern = Spacing(
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
    xxxl: 64
  )
}

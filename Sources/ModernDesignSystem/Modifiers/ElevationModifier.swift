//
//  ElevationModifier.swift
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

public struct ElevationModifier: ViewModifier {
  let elevation: ElevationLevel

  public init(_ elevation: ElevationLevel) {
    self.elevation = elevation
  }

  public func body(content: Content) -> some View {
    content
      .shadow(
        color: elevation.shadowColor,
        radius: elevation.shadowRadius,
        x: elevation.shadowOffset.width,
        y: elevation.shadowOffset.height
      )
  }
}

public enum ElevationLevel {
  case none
  case xs
  case sm
  case md
  case lg
  case xl
  case xxl

  var shadowColor: Color {
    Color.black.opacity(shadowOpacity)
  }

  var shadowRadius: CGFloat {
    switch self {
    case .none: return 0
    case .xs: return 2
    case .sm: return 4
    case .md: return 8
    case .lg: return 16
    case .xl: return 24
    case .xxl: return 32
    }
  }

  var shadowOffset: CGSize {
    switch self {
    case .none: return CGSize(width: 0, height: 0)
    case .xs: return CGSize(width: 0, height: 1)
    case .sm: return CGSize(width: 0, height: 2)
    case .md: return CGSize(width: 0, height: 4)
    case .lg: return CGSize(width: 0, height: 8)
    case .xl: return CGSize(width: 0, height: 12)
    case .xxl: return CGSize(width: 0, height: 16)
    }
  }

  var shadowOpacity: Double {
    switch self {
    case .none: return 0
    case .xs: return 0.1
    case .sm: return 0.1
    case .md: return 0.15
    case .lg: return 0.2
    case .xl: return 0.25
    case .xxl: return 0.3
    }
  }
}

// MARK: - View Extension

public extension View {
  func elevation(_ level: ElevationLevel) -> some View {
    modifier(ElevationModifier(level))
  }
}

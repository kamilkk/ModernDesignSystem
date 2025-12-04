//
//  MaterialStyles.swift
//  ModernDesignSystem
//
//  Created by Kamil Kowalski on 04/12/2025.
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

public enum MaterialStyle: CaseIterable, Sendable {
  case glass // Ultra-thin with high vibrancy
  case frosted // Thick with medium blur
  case subtle // Regular with low opacity
  case prominent // Thick with high opacity

  public var material: Material {
    switch self {
    case .glass:
      return .ultraThinMaterial
    case .frosted:
      return .thickMaterial
    case .subtle:
      return .regularMaterial
    case .prominent:
      return .thickMaterial
    }
  }

  public var opacity: Double {
    switch self {
    case .glass:
      return 0.9
    case .frosted:
      return 0.8
    case .subtle:
      return 0.5
    case .prominent:
      return 0.95
    }
  }
}

// MARK: - View Extension

public extension View {
  /// Applies a material style with the specified preset
  func materialStyle(_ style: MaterialStyle) -> some View {
    background(style.material)
      .opacity(style.opacity)
  }
}

// MARK: - Previews

#if DEBUG
  @available(iOS 17.0, macOS 14.0, *)
  #Preview {
    ZStack {
      // Background gradient
      LinearGradient(
        gradient: Gradient(colors: [.blue, .purple]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
      .ignoresSafeArea()

      ScrollView {
        VStack(spacing: 24) {
          Text("Material Styles")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()

          ForEach(MaterialStyle.allCases, id: \.self) { style in
            VStack(spacing: 12) {
              Text(String(describing: style).capitalized)
                .font(.headline)

              Text("The quick brown fox jumps over the lazy dog")
                .font(.body)
                .multilineTextAlignment(.center)
            }
            .padding(24)
            .materialStyle(style)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
          }
        }
        .padding(.vertical)
      }
    }
  }
#endif

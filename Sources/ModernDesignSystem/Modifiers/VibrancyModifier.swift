//
//  VibrancyModifier.swift
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

public struct VibrancyModifier: ViewModifier {
  let intensity: Double

  public init(intensity: Double = 1.0) {
    self.intensity = intensity
  }

  public func body(content: Content) -> some View {
    content
      .foregroundStyle(.primary)
      .blendMode(.plusLighter)
      .opacity(intensity)
  }
}

// MARK: - View Extension

public extension View {
  /// Applies vibrancy effect with specified intensity
  /// - Parameter intensity: The intensity of the vibrancy effect (0.0 to 1.0)
  func vibrancy(intensity: Double = 1.0) -> some View {
    modifier(VibrancyModifier(intensity: intensity))
  }
}

// MARK: - Previews

#if DEBUG
  @available(iOS 17.0, macOS 14.0, *)
  #Preview {
    ZStack {
      // Background with material
      LinearGradient(
        gradient: Gradient(colors: [.blue, .purple]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
      .ignoresSafeArea()

      VStack(spacing: 32) {
        Text("Vibrancy Effect Demo")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(.white)

        VStack(spacing: 24) {
          VStack(spacing: 8) {
            Text("No Vibrancy")
              .font(.headline)

            Text("The quick brown fox")
              .font(.body)
          }
          .padding()
          .background(.ultraThinMaterial)
          .clipShape(RoundedRectangle(cornerRadius: 12))

          VStack(spacing: 8) {
            Text("Vibrancy (0.5)")
              .font(.headline)
              .vibrancy(intensity: 0.5)

            Text("The quick brown fox")
              .font(.body)
              .vibrancy(intensity: 0.5)
          }
          .padding()
          .background(.ultraThinMaterial)
          .clipShape(RoundedRectangle(cornerRadius: 12))

          VStack(spacing: 8) {
            Text("Vibrancy (1.0)")
              .font(.headline)
              .vibrancy(intensity: 1.0)

            Text("The quick brown fox")
              .font(.body)
              .vibrancy(intensity: 1.0)
          }
          .padding()
          .background(.ultraThinMaterial)
          .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
      }
    }
  }
#endif

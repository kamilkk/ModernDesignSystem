//
//  Loader.swift
//  ModernDesignSystem
//
//  Created by Kamil Kowalski on 01/09/2025.
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

public enum LoaderColor: String, CaseIterable {
  case primary
  case secondary
  case accent
  case muted
}

public enum LoaderSize: CaseIterable, Sendable {
  case small
  case medium
  case large

  var diameter: CGFloat {
    switch self {
    case .small: return 20
    case .medium: return 32
    case .large: return 48
    }
  }

  var lineWidth: CGFloat {
    switch self {
    case .small: return 2
    case .medium: return 3
    case .large: return 4
    }
  }
}

public struct ModernLoader: View {
  @EnvironmentObject private var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.loaderBackgroundColor) private var backgroundColor
  @Environment(\.loaderSize) private var environmentSize: LoaderSize?

  @State private var rotationAngle: Double = 0

  private let color: LoaderColor
  private let size: LoaderSize?

  public init(
    color: LoaderColor = .primary,
    size: LoaderSize? = nil
  ) {
    self.color = color
    self.size = size
  }

  public var body: some View {
    let currentSize = size ?? environmentSize ?? .medium

    ZStack {
      Circle()
        .stroke(
          designSystem.color(\.tertiaryBackground, systemScheme: colorScheme),
          lineWidth: currentSize.lineWidth
        )

      Circle()
        .trim(from: 0.25, to: 1)
        .stroke(
          loaderColor,
          style: StrokeStyle(
            lineWidth: currentSize.lineWidth,
            lineCap: .round
          )
        )
        .rotationEffect(.degrees(rotationAngle))
        .onAppear {
          withAnimation(
            .linear(duration: 1)
              .repeatForever(autoreverses: false)
          ) {
            rotationAngle = 360
          }
        }
    }
    .frame(
      width: currentSize.diameter,
      height: currentSize.diameter
    )
    .background(backgroundColor)
  }

  private var loaderColor: Color {
    switch color {
    case .primary:
      return designSystem.color(\.primary, systemScheme: colorScheme)
    case .secondary:
      return designSystem.color(\.secondary, systemScheme: colorScheme)
    case .accent:
      return designSystem.color(\.accent, systemScheme: colorScheme)
    case .muted:
      return designSystem.color(\.secondaryText, systemScheme: colorScheme)
    }
  }
}

// MARK: - Environment Support

private struct LoaderBackgroundColor: EnvironmentKey {
  static let defaultValue: Color = .clear
}

private struct LoaderSizeKey: EnvironmentKey {
  static let defaultValue: LoaderSize? = nil
}

extension EnvironmentValues {
  var loaderBackgroundColor: Color {
    get { self[LoaderBackgroundColor.self] }
    set { self[LoaderBackgroundColor.self] = newValue }
  }

  var loaderSize: LoaderSize? {
    get { self[LoaderSizeKey.self] }
    set { self[LoaderSizeKey.self] = newValue }
  }
}

// MARK: - View Extensions

public extension View {
  func loaderBackgroundColor(_ color: Color) -> some View {
    environment(\.loaderBackgroundColor, color)
  }

  func loaderSize(_ size: LoaderSize) -> some View {
    environment(\.loaderSize, size)
  }

  func loader(_ isLoading: Bool, identifier: String = "Loader") -> some View {
    overlay {
      if isLoading {
        ZStack {
          Color.black.opacity(0.3)
            .ignoresSafeArea()

          ModernLoader()
            .accessibilityIdentifier(identifier)
        }
      }
    }
  }

  func loader(
    _ isLoading: Bool,
    color: LoaderColor = .primary,
    size: LoaderSize = .medium,
    identifier: String = "Loader"
  ) -> some View {
    overlay {
      if isLoading {
        ZStack {
          Color.black.opacity(0.3)
            .ignoresSafeArea()

          ModernLoader(color: color, size: size)
            .accessibilityIdentifier(identifier)
        }
      }
    }
  }
}

// MARK: - Previews

#if DEBUG
  @available(iOS 17.0, macOS 14.0, *)
  #Preview {
    ScrollView {
      VStack(spacing: 24) {
        Text("Loader Component Demo")
          .font(.title)
          .fontWeight(.bold)
          .padding()

        VStack(spacing: 16) {
          Text("Different Sizes")
            .font(.headline)

          HStack(spacing: 24) {
            VStack(spacing: 8) {
              ModernLoader(size: .small)
              Text("Small")
                .font(.caption)
            }

            VStack(spacing: 8) {
              ModernLoader(size: .medium)
              Text("Medium")
                .font(.caption)
            }

            VStack(spacing: 8) {
              ModernLoader(size: .large)
              Text("Large")
                .font(.caption)
            }
          }
        }

        VStack(spacing: 16) {
          Text("Different Colors")
            .font(.headline)

          HStack(spacing: 24) {
            VStack(spacing: 8) {
              ModernLoader(color: .primary)
              Text("Primary")
                .font(.caption)
            }

            VStack(spacing: 8) {
              ModernLoader(color: .secondary)
              Text("Secondary")
                .font(.caption)
            }

            VStack(spacing: 8) {
              ModernLoader(color: .accent)
              Text("Accent")
                .font(.caption)
            }

            VStack(spacing: 8) {
              ModernLoader(color: .muted)
              Text("Muted")
                .font(.caption)
            }
          }
        }

        VStack(spacing: 16) {
          Text("With Background")
            .font(.headline)

          ModernLoader()
            .loaderBackgroundColor(Color.gray.opacity(0.1))
            .padding(24)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
      }
      .padding()
    }
    .environmentObject(ModernDesignSystem.shared)
  }
#endif

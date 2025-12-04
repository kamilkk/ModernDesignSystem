//
//  Card.swift
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

public struct ModernCard<Content: View>: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  private let content: Content
  private let elevation: CardElevation
  private let padding: EdgeInsets
  private let cornerRadius: CGFloat

  public init(
    elevation: CardElevation = .medium,
    padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
    cornerRadius: CGFloat = 12,
    @ViewBuilder content: () -> Content
  ) {
    self.elevation = elevation
    self.padding = padding
    self.cornerRadius = cornerRadius
    self.content = content()
  }

  public var body: some View {
    content
      .padding(padding)
      .background(backgroundColor)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      .shadow(
        color: shadowColor,
        radius: elevation.shadowRadius,
        x: elevation.shadowOffset.width,
        y: elevation.shadowOffset.height
      )
  }

  private var backgroundColor: Color {
    designSystem.color(\.primaryBackground, systemScheme: colorScheme)
  }

  private var shadowColor: Color {
    Color.black.opacity(elevation.shadowOpacity)
  }
}

public enum CardElevation: Sendable {
  case none
  case low
  case medium
  case high

  var shadowRadius: CGFloat {
    switch self {
    case .none: return 0
    case .low: return 2
    case .medium: return 4
    case .high: return 8
    }
  }

  var shadowOffset: CGSize {
    switch self {
    case .none: return CGSize(width: 0, height: 0)
    case .low: return CGSize(width: 0, height: 1)
    case .medium: return CGSize(width: 0, height: 2)
    case .high: return CGSize(width: 0, height: 4)
    }
  }

  var shadowOpacity: Double {
    switch self {
    case .none: return 0
    case .low: return 0.1
    case .medium: return 0.15
    case .high: return 0.2
    }
  }
}

// MARK: - Specialized Card Types

public struct InfoCard: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  private let title: String
  private let subtitle: String?
  private let image: String?
  private let action: (() -> Void)?

  public init(
    title: String,
    subtitle: String? = nil,
    image: String? = nil,
    action: (() -> Void)? = nil
  ) {
    self.title = title
    self.subtitle = subtitle
    self.image = image
    self.action = action
  }

  public var body: some View {
    ModernCard {
      HStack(spacing: designSystem.brand.spacing.md) {
        if let image = image {
          Image(systemName: image)
            .font(.system(size: 24))
            .foregroundColor(designSystem.color(\.primary, systemScheme: colorScheme))
            .frame(width: 40, height: 40)
        }

        VStack(alignment: .leading, spacing: designSystem.brand.spacing.xs) {
          Text(title)
            .font(designSystem.brand.typography.titleMedium.font(
              verticalSizeClass: nil,
              horizontalSizeClass: nil
            ))
            .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

          if let subtitle = subtitle {
            Text(subtitle)
              .font(designSystem.brand.typography.bodyMedium.font(
                verticalSizeClass: nil,
                horizontalSizeClass: nil
              ))
              .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))
          }
        }

        Spacer()

        if action != nil {
          Image(systemName: "chevron.right")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(designSystem.color(\.tertiaryText, systemScheme: colorScheme))
        }
      }
    }
    .onTapGesture {
      action?()
    }
  }
}

public struct ProductCard: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  private let title: String
  private let description: String?
  private let price: String?
  private let image: String?
  private let action: (() -> Void)?

  public init(
    title: String,
    description: String? = nil,
    price: String? = nil,
    image: String? = nil,
    action: (() -> Void)? = nil
  ) {
    self.title = title
    self.description = description
    self.price = price
    self.image = image
    self.action = action
  }

  public var body: some View {
    ModernCard {
      VStack(alignment: .leading, spacing: designSystem.brand.spacing.md) {
        if let image = image {
          AsyncImage(url: URL(string: image)) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
          } placeholder: {
            Rectangle()
              .fill(designSystem.color(\.secondaryBackground, systemScheme: colorScheme))
              .overlay(
                Image(systemName: "photo")
                  .foregroundColor(designSystem.color(\.tertiaryText, systemScheme: colorScheme))
              )
          }
          .frame(height: 160)
          .clipShape(RoundedRectangle(cornerRadius: 8))
        }

        VStack(alignment: .leading, spacing: designSystem.brand.spacing.xs) {
          Text(title)
            .font(designSystem.brand.typography.titleMedium.font(
              verticalSizeClass: nil,
              horizontalSizeClass: nil
            ))
            .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

          if let description = description {
            Text(description)
              .font(designSystem.brand.typography.bodySmall.font(
                verticalSizeClass: nil,
                horizontalSizeClass: nil
              ))
              .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))
              .lineLimit(2)
          }

          if let price = price {
            Text(price)
              .font(designSystem.brand.typography.titleSmall.font(
                verticalSizeClass: nil,
                horizontalSizeClass: nil
              ))
              .foregroundColor(designSystem.color(\.primary, systemScheme: colorScheme))
          }
        }

        if action != nil {
          Button("Add to Cart") {
            action?()
          }
          .buttonStyle(ModernButtonStyle(type: .primary, size: .small))
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
      VStack(spacing: 16) {
        InfoCard(
          title: "Settings",
          subtitle: "Manage your preferences",
          image: "gear",
          action: {}
        )

        ProductCard(
          title: "Modern Design System",
          description: "A comprehensive design system for modern applications",
          price: "$99.99",
          action: {}
        )

        ModernCard(elevation: .high) {
          VStack(spacing: 12) {
            Text("Custom Card")
              .font(.title2)
              .fontWeight(.semibold)

            Text("This is a custom card with high elevation")
              .font(.body)
              .foregroundColor(.secondary)
          }
        }
      }
      .padding()
    }
    .environmentObject(ModernDesignSystem.shared)
  }
#endif

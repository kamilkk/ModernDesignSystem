//
//  EmptyStateView.swift
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

public struct EmptyStateView: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  private let image: Image
  private let title: String
  private let subtitle: String?
  private let actionTitle: String?
  private let action: (() -> Void)?

  public init(
    image: Image,
    title: String,
    subtitle: String? = nil,
    actionTitle: String? = nil,
    action: (() -> Void)? = nil
  ) {
    self.image = image
    self.title = title
    self.subtitle = subtitle
    self.actionTitle = actionTitle
    self.action = action
  }

  public var body: some View {
    VStack(spacing: designSystem.brand.spacing.lg) {
      Spacer()

      // Image
      image
        .font(.system(size: 64))
        .foregroundColor(designSystem.color(\.tertiaryText, systemScheme: colorScheme))
        .padding(.bottom, designSystem.brand.spacing.md)

      // Title
      Text(title)
        .font(designSystem.brand.typography.headlineSmall.font(
          verticalSizeClass: nil,
          horizontalSizeClass: nil
        ))
        .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))
        .multilineTextAlignment(.center)

      // Subtitle
      if let subtitle = subtitle {
        Text(subtitle)
          .font(designSystem.brand.typography.bodyMedium.font(
            verticalSizeClass: nil,
            horizontalSizeClass: nil
          ))
          .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))
          .multilineTextAlignment(.center)
          .padding(.horizontal, designSystem.brand.spacing.xl)
      }

      // Action button
      if let actionTitle = actionTitle, let action = action {
        Button(actionTitle) {
          action()
        }
        .buttonStyle(ModernButtonStyle(type: .primary, size: .medium))
        .padding(.top, designSystem.brand.spacing.md)
      }

      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(designSystem.brand.spacing.lg)
  }
}

// MARK: - Document-Specific Presets

public extension EmptyStateView {
  static func noDocuments(
    action: @escaping () -> Void
  ) -> EmptyStateView {
    EmptyStateView(
      image: Image(systemName: "doc.text.magnifyingglass"),
      title: "No Documents",
      subtitle: "Add documents to get started",
      actionTitle: "Open Documents",
      action: action
    )
  }

  static func noSearchResults(
    query: String
  ) -> EmptyStateView {
    EmptyStateView(
      image: Image(systemName: "magnifyingglass"),
      title: "No Results",
      subtitle: "No documents match '\(query)'",
      actionTitle: nil,
      action: nil
    )
  }

  static func noFavorites(
    action: @escaping () -> Void
  ) -> EmptyStateView {
    EmptyStateView(
      image: Image(systemName: "star"),
      title: "No Favorites",
      subtitle: "Star documents to add them to favorites",
      actionTitle: "Browse Documents",
      action: action
    )
  }
}

// MARK: - Previews

#if DEBUG
  @available(iOS 17.0, macOS 14.0, *)
  #Preview {
    TabView {
      EmptyStateView.noDocuments {
        print("Open documents tapped")
      }
      .environmentObject(ModernDesignSystem.shared)
      .tabItem {
        Label("No Documents", systemImage: "doc")
      }

      EmptyStateView.noSearchResults(query: "budget 2025")
        .environmentObject(ModernDesignSystem.shared)
        .tabItem {
          Label("No Results", systemImage: "magnifyingglass")
        }

      EmptyStateView.noFavorites {
        print("Browse documents tapped")
      }
      .environmentObject(ModernDesignSystem.shared)
      .tabItem {
        Label("No Favorites", systemImage: "star")
      }
    }
  }
#endif

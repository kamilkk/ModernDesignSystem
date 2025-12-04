//
//  Notification.swift
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

public struct ModernNotification: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  private let type: NotificationType
  private let title: String
  private let message: String?
  private let action: (() -> Void)?
  private let actionTitle: String?
  private let onDismiss: (() -> Void)?

  public init(
    type: NotificationType,
    title: String,
    message: String? = nil,
    action: (() -> Void)? = nil,
    actionTitle: String? = nil,
    onDismiss: (() -> Void)? = nil
  ) {
    self.type = type
    self.title = title
    self.message = message
    self.action = action
    self.actionTitle = actionTitle
    self.onDismiss = onDismiss
  }

  public var body: some View {
    HStack(spacing: designSystem.brand.spacing.md) {
      // Icon
      Image(systemName: type.iconName)
        .font(.system(size: 20, weight: .medium))
        .foregroundColor(type.iconColor(for: designSystem.currentColorSet))

      // Content
      VStack(alignment: .leading, spacing: designSystem.brand.spacing.xs) {
        Text(title)
          .font(designSystem.brand.typography.labelMedium.font(
            verticalSizeClass: nil,
            horizontalSizeClass: nil
          ))
          .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

        if let message = message {
          Text(message)
            .font(designSystem.brand.typography.bodySmall.font(
              verticalSizeClass: nil,
              horizontalSizeClass: nil
            ))
            .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))
        }
      }

      Spacer()

      // Action button
      if let action = action, let actionTitle = actionTitle {
        Button(action: action) {
          Text(actionTitle)
            .font(designSystem.brand.typography.labelSmall.font(
              verticalSizeClass: nil,
              horizontalSizeClass: nil
            ))
            .foregroundColor(type.actionColor(for: designSystem.currentColorSet))
        }
      }

      // Dismiss button
      if let onDismiss = onDismiss {
        Button(action: onDismiss) {
          Image(systemName: "xmark")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))
        }
      }
    }
    .padding(designSystem.brand.spacing.md)
    .background(type.backgroundColor(for: designSystem.currentColorSet))
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .stroke(type.borderColor(for: designSystem.currentColorSet), lineWidth: 1)
    )
    .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}

public enum NotificationType: Sendable {
  case info
  case success
  case warning
  case error

  var iconName: String {
    switch self {
    case .info:
      return "info.circle.fill"
    case .success:
      return "checkmark.circle.fill"
    case .warning:
      return "exclamationmark.triangle.fill"
    case .error:
      return "xmark.circle.fill"
    }
  }

  func iconColor(for colorSet: ColorSet) -> Color {
    switch self {
    case .info:
      return colorSet.tintColor
    case .success:
      return .green
    case .warning:
      return .orange
    case .error:
      return .red
    }
  }

  func backgroundColor(for colorSet: ColorSet) -> Color {
    switch self {
    case .info:
      return colorSet.tintColor.opacity(0.1)
    case .success:
      return Color.green.opacity(0.1)
    case .warning:
      return Color.orange.opacity(0.1)
    case .error:
      return Color.red.opacity(0.1)
    }
  }

  func borderColor(for colorSet: ColorSet) -> Color {
    switch self {
    case .info:
      return colorSet.tintColor.opacity(0.3)
    case .success:
      return Color.green.opacity(0.3)
    case .warning:
      return Color.orange.opacity(0.3)
    case .error:
      return Color.red.opacity(0.3)
    }
  }

  func actionColor(for colorSet: ColorSet) -> Color {
    switch self {
    case .info:
      return colorSet.tintColor
    case .success:
      return .green
    case .warning:
      return .orange
    case .error:
      return .red
    }
  }
}

// MARK: - Previews

#if DEBUG
  @available(iOS 17.0, macOS 14.0, *)
  #Preview {
    VStack(spacing: 16) {
      ModernNotification(
        type: .info,
        title: "Information",
        message: "This is an informational message.",
        action: {},
        actionTitle: "Learn More",
        onDismiss: {}
      )

      ModernNotification(
        type: .success,
        title: "Success",
        message: "Your action was completed successfully.",
        onDismiss: {}
      )

      ModernNotification(
        type: .warning,
        title: "Warning",
        message: "Please review your input before proceeding."
      )

      ModernNotification(
        type: .error,
        title: "Error",
        message: "Something went wrong. Please try again.",
        action: {},
        actionTitle: "Retry"
      )
    }
    .padding()
    .environmentObject(ModernDesignSystem.shared)
  }
#endif

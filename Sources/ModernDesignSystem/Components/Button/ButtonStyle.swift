//
//  ButtonStyle.swift
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

public struct ModernButtonStyle: ButtonStyle {
    @Environment(\.buttonCollapsed) var collapsed
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var designSystem: ModernDesignSystem
    
    let type: ButtonType
    let size: ButtonSize
    let iconPosition: IconPosition
    let maxWidth: CGFloat?
    
    public init(
        type: ButtonType = .primary,
        size: ButtonSize = .medium,
        iconPosition: IconPosition = .leading,
        maxWidth: CGFloat? = nil
    ) {
        self.type = type
        self.size = size
        self.iconPosition = iconPosition
        self.maxWidth = maxWidth
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        let view = baseLabel(configuration: configuration)
        
        Group {
            if configuration.isPressed {
                view
                    .foregroundStyle(type.tintPressed(for: designSystem.currentColorSet))
                    .background(type.backgroundPressed(for: designSystem.currentColorSet))
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(type.borderPressed(for: designSystem.currentColorSet), lineWidth: 1)
                    )
            } else if !isEnabled {
                view
                    .foregroundStyle(type.tintDisabled(for: designSystem.currentColorSet))
                    .background(type.backgroundDisabled(for: designSystem.currentColorSet))
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(type.borderDisabled(for: designSystem.currentColorSet), lineWidth: 1)
                    )
            } else {
                view
                    .foregroundStyle(type.tint(for: designSystem.currentColorSet))
                    .background(type.background(for: designSystem.currentColorSet))
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(type.border(for: designSystem.currentColorSet), lineWidth: 1)
                    )
            }
        }
        .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
    
    @ViewBuilder
    private func baseLabel(configuration: Configuration) -> some View {
        HStack(spacing: designSystem.brand.spacing.sm) {
            if iconPosition == .leading, let icon = type.icon {
                Image(systemName: icon)
                    .font(.system(size: size.iconSize))
            }
            
            configuration.label
                .font(size.font(from: designSystem.brand.typography))
                .lineLimit(1)
            
            if iconPosition == .trailing, let icon = type.icon {
                Image(systemName: icon)
                    .font(.system(size: size.iconSize))
            }
        }
        .padding(.horizontal, size.horizontalPadding)
        .padding(.vertical, size.verticalPadding)
        .frame(maxWidth: maxWidth)
    }
}

public enum ButtonType: Sendable {
    case primary
    case secondary
    case tertiary
    case destructive
    
    var icon: String? {
        switch self {
        case .primary, .secondary, .tertiary, .destructive:
            return nil
        }
    }
    
    func tint(for colorSet: ColorSet) -> Color {
        switch self {
        case .primary:
            return colorSet.primaryBackgroundColor
        case .secondary:
            return colorSet.tintColor
        case .tertiary:
            return colorSet.tintColor
        case .destructive:
            return .white
        }
    }
    
    func background(for colorSet: ColorSet) -> Color {
        switch self {
        case .primary:
            return colorSet.tintColor
        case .secondary:
            return colorSet.secondaryBackgroundColor
        case .tertiary:
            return .clear
        case .destructive:
            return .red
        }
    }
    
    func border(for colorSet: ColorSet) -> Color {
        switch self {
        case .primary:
            return .clear
        case .secondary:
            return colorSet.tintColor
        case .tertiary:
            return colorSet.tintColor
        case .destructive:
            return .clear
        }
    }
    
    func tintPressed(for colorSet: ColorSet) -> Color {
        tint(for: colorSet).opacity(0.8)
    }
    
    func backgroundPressed(for colorSet: ColorSet) -> Color {
        background(for: colorSet).opacity(0.8)
    }
    
    func borderPressed(for colorSet: ColorSet) -> Color {
        border(for: colorSet).opacity(0.8)
    }
    
    func tintDisabled(for colorSet: ColorSet) -> Color {
        colorSet.quaternaryLabelColor
    }
    
    func backgroundDisabled(for colorSet: ColorSet) -> Color {
        colorSet.secondaryBackgroundColor.opacity(0.5)
    }
    
    func borderDisabled(for colorSet: ColorSet) -> Color {
        colorSet.quaternaryLabelColor.opacity(0.3)
    }
}

public enum ButtonSize: Sendable {
    case small
    case medium
    case large
    
    var horizontalPadding: CGFloat {
        switch self {
        case .small: return 12
        case .medium: return 16
        case .large: return 20
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .small: return 8
        case .medium: return 12
        case .large: return 16
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .small: return 14
        case .medium: return 16
        case .large: return 18
        }
    }
    
    func font(from typography: FontTokens) -> Font {
        switch self {
        case .small:
            return typography.labelSmall.font(verticalSizeClass: nil, horizontalSizeClass: nil)
        case .medium:
            return typography.labelMedium.font(verticalSizeClass: nil, horizontalSizeClass: nil)
        case .large:
            return typography.labelLarge.font(verticalSizeClass: nil, horizontalSizeClass: nil)
        }
    }
}

public enum IconPosition: Sendable {
    case leading
    case trailing
}

// MARK: - Environment Keys
public struct ButtonCollapsedKey: EnvironmentKey {
    public static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var buttonCollapsed: Bool {
        get { self[ButtonCollapsedKey.self] }
        set { self[ButtonCollapsedKey.self] = newValue }
    }
}

// MARK: - View Extensions
public extension View {
    func buttonCollapsed(_ collapsed: Bool) -> some View {
        environment(\.buttonCollapsed, collapsed)
    }
}
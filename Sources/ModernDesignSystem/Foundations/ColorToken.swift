//
//  ColorToken.swift
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

public struct ColorToken: Codable, Hashable, Sendable {
    public let red: CGFloat
    public let green: CGFloat
    public let blue: CGFloat
    public let opacity: CGFloat
    
    public init(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }
    
    public var color: Color {
        Color(red: red, green: green, blue: blue, opacity: opacity)
    }
}

public struct GlobalColors: Codable, Hashable, Sendable {
    // Primary colors
    public let primary100: ColorToken
    public let primary200: ColorToken
    public let primary300: ColorToken
    public let primary400: ColorToken
    public let primary500: ColorToken
    public let primary600: ColorToken
    public let primary700: ColorToken
    public let primary800: ColorToken
    public let primary900: ColorToken
    
    // Secondary colors
    public let secondary100: ColorToken
    public let secondary200: ColorToken
    public let secondary300: ColorToken
    public let secondary400: ColorToken
    public let secondary500: ColorToken
    public let secondary600: ColorToken
    public let secondary700: ColorToken
    public let secondary800: ColorToken
    public let secondary900: ColorToken
    
    // Neutral colors
    public let neutral100: ColorToken
    public let neutral200: ColorToken
    public let neutral300: ColorToken
    public let neutral400: ColorToken
    public let neutral500: ColorToken
    public let neutral600: ColorToken
    public let neutral700: ColorToken
    public let neutral800: ColorToken
    public let neutral900: ColorToken
    
    // Success colors
    public let success100: ColorToken
    public let success200: ColorToken
    public let success300: ColorToken
    public let success400: ColorToken
    public let success500: ColorToken
    public let success600: ColorToken
    public let success700: ColorToken
    public let success800: ColorToken
    public let success900: ColorToken
    
    // Warning colors
    public let warning100: ColorToken
    public let warning200: ColorToken
    public let warning300: ColorToken
    public let warning400: ColorToken
    public let warning500: ColorToken
    public let warning600: ColorToken
    public let warning700: ColorToken
    public let warning800: ColorToken
    public let warning900: ColorToken
    
    // Error colors
    public let error100: ColorToken
    public let error200: ColorToken
    public let error300: ColorToken
    public let error400: ColorToken
    public let error500: ColorToken
    public let error600: ColorToken
    public let error700: ColorToken
    public let error800: ColorToken
    public let error900: ColorToken
    
    public init(
        primary100: ColorToken, primary200: ColorToken, primary300: ColorToken, primary400: ColorToken, primary500: ColorToken,
        primary600: ColorToken, primary700: ColorToken, primary800: ColorToken, primary900: ColorToken,
        secondary100: ColorToken, secondary200: ColorToken, secondary300: ColorToken, secondary400: ColorToken, secondary500: ColorToken,
        secondary600: ColorToken, secondary700: ColorToken, secondary800: ColorToken, secondary900: ColorToken,
        neutral100: ColorToken, neutral200: ColorToken, neutral300: ColorToken, neutral400: ColorToken, neutral500: ColorToken,
        neutral600: ColorToken, neutral700: ColorToken, neutral800: ColorToken, neutral900: ColorToken,
        success100: ColorToken, success200: ColorToken, success300: ColorToken, success400: ColorToken, success500: ColorToken,
        success600: ColorToken, success700: ColorToken, success800: ColorToken, success900: ColorToken,
        warning100: ColorToken, warning200: ColorToken, warning300: ColorToken, warning400: ColorToken, warning500: ColorToken,
        warning600: ColorToken, warning700: ColorToken, warning800: ColorToken, warning900: ColorToken,
        error100: ColorToken, error200: ColorToken, error300: ColorToken, error400: ColorToken, error500: ColorToken,
        error600: ColorToken, error700: ColorToken, error800: ColorToken, error900: ColorToken
    ) {
        self.primary100 = primary100
        self.primary200 = primary200
        self.primary300 = primary300
        self.primary400 = primary400
        self.primary500 = primary500
        self.primary600 = primary600
        self.primary700 = primary700
        self.primary800 = primary800
        self.primary900 = primary900
        
        self.secondary100 = secondary100
        self.secondary200 = secondary200
        self.secondary300 = secondary300
        self.secondary400 = secondary400
        self.secondary500 = secondary500
        self.secondary600 = secondary600
        self.secondary700 = secondary700
        self.secondary800 = secondary800
        self.secondary900 = secondary900
        
        self.neutral100 = neutral100
        self.neutral200 = neutral200
        self.neutral300 = neutral300
        self.neutral400 = neutral400
        self.neutral500 = neutral500
        self.neutral600 = neutral600
        self.neutral700 = neutral700
        self.neutral800 = neutral800
        self.neutral900 = neutral900
        
        self.success100 = success100
        self.success200 = success200
        self.success300 = success300
        self.success400 = success400
        self.success500 = success500
        self.success600 = success600
        self.success700 = success700
        self.success800 = success800
        self.success900 = success900
        
        self.warning100 = warning100
        self.warning200 = warning200
        self.warning300 = warning300
        self.warning400 = warning400
        self.warning500 = warning500
        self.warning600 = warning600
        self.warning700 = warning700
        self.warning800 = warning800
        self.warning900 = warning900
        
        self.error100 = error100
        self.error200 = error200
        self.error300 = error300
        self.error400 = error400
        self.error500 = error500
        self.error600 = error600
        self.error700 = error700
        self.error800 = error800
        self.error900 = error900
    }
}

public typealias ColorPath = KeyPath<SemanticColors, SemanticColorToken>
public typealias GlobalColorPath = KeyPath<GlobalColors, ColorToken>

public struct SemanticColorToken: Hashable {
    public let light: GlobalColorPath
    public let dark: GlobalColorPath
    
    public init(light: GlobalColorPath, dark: GlobalColorPath) {
        self.light = light
        self.dark = dark
    }
    
    public subscript(theme: Theme) -> GlobalColorPath {
        switch theme {
        case .light:
            return light
        case .dark:
            return dark
        }
    }
    
    public var path: GlobalColorPath {
        light // Default to light, will be resolved at runtime
    }
}

public struct SemanticColors: Hashable {
    // Background colors
    public let primaryBackground: SemanticColorToken
    public let secondaryBackground: SemanticColorToken
    public let tertiaryBackground: SemanticColorToken
    
    // Text colors
    public let primaryText: SemanticColorToken
    public let secondaryText: SemanticColorToken
    public let tertiaryText: SemanticColorToken
    public let quaternaryText: SemanticColorToken
    
    // Interactive colors
    public let primary: SemanticColorToken
    public let secondary: SemanticColorToken
    public let accent: SemanticColorToken
    
    // Status colors
    public let success: SemanticColorToken
    public let warning: SemanticColorToken
    public let error: SemanticColorToken
    public let info: SemanticColorToken
    
    // Border colors
    public let primaryBorder: SemanticColorToken
    public let secondaryBorder: SemanticColorToken
    
    public init(
        primaryBackground: SemanticColorToken,
        secondaryBackground: SemanticColorToken,
        tertiaryBackground: SemanticColorToken,
        primaryText: SemanticColorToken,
        secondaryText: SemanticColorToken,
        tertiaryText: SemanticColorToken,
        quaternaryText: SemanticColorToken,
        primary: SemanticColorToken,
        secondary: SemanticColorToken,
        accent: SemanticColorToken,
        success: SemanticColorToken,
        warning: SemanticColorToken,
        error: SemanticColorToken,
        info: SemanticColorToken,
        primaryBorder: SemanticColorToken,
        secondaryBorder: SemanticColorToken
    ) {
        self.primaryBackground = primaryBackground
        self.secondaryBackground = secondaryBackground
        self.tertiaryBackground = tertiaryBackground
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.tertiaryText = tertiaryText
        self.quaternaryText = quaternaryText
        self.primary = primary
        self.secondary = secondary
        self.accent = accent
        self.success = success
        self.warning = warning
        self.error = error
        self.info = info
        self.primaryBorder = primaryBorder
        self.secondaryBorder = secondaryBorder
    }
}
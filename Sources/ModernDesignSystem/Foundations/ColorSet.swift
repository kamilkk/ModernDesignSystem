//
//  ColorSet.swift
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
//  Inspired by IceCubesApp theming system
//

import SwiftUI

public protocol ColorSet: Sendable {
    var name: ColorSetName { get }
    var scheme: ColorScheme { get }
    var tintColor: Color { get }
    var primaryBackgroundColor: Color { get }
    var secondaryBackgroundColor: Color { get }
    var labelColor: Color { get }
    var secondaryLabelColor: Color { get }
    var tertiaryLabelColor: Color { get }
    var quaternaryLabelColor: Color { get }
}

public enum ColorSetName: String, CaseIterable, Sendable {
    case modernBlue = "Modern Blue"
    case modernBlueDark = "Modern Blue - Dark"
    case oceanBreeze = "Ocean Breeze"
    case oceanBreezeDark = "Ocean Breeze - Dark"
    case forestGreen = "Forest Green"
    case forestGreenDark = "Forest Green - Dark"
    case sunsetOrange = "Sunset Orange"
    case sunsetOrangeDark = "Sunset Orange - Dark"
    case deepPurple = "Deep Purple"
    case deepPurpleDark = "Deep Purple - Dark"
    case charcoal = "Charcoal"
    case charcoalDark = "Charcoal - Dark"
}

// MARK: - Modern Blue Theme
public struct ModernBlueColorSet: ColorSet {
    public let name: ColorSetName = .modernBlue
    public let scheme: ColorScheme = .light
    public let tintColor: Color = .init(hex: 0x007AFF)
    public let primaryBackgroundColor: Color = .init(hex: 0xFFFFFF)
    public let secondaryBackgroundColor: Color = .init(hex: 0xF2F2F7)
    public let labelColor: Color = .init(hex: 0x000000)
    public let secondaryLabelColor: Color = .init(hex: 0x3C3C43).opacity(0.6)
    public let tertiaryLabelColor: Color = .init(hex: 0x3C3C43).opacity(0.3)
    public let quaternaryLabelColor: Color = .init(hex: 0x3C3C43).opacity(0.18)
}

public struct ModernBlueDarkColorSet: ColorSet {
    public let name: ColorSetName = .modernBlueDark
    public let scheme: ColorScheme = .dark
    public let tintColor: Color = .init(hex: 0x0A84FF)
    public let primaryBackgroundColor: Color = .init(hex: 0x000000)
    public let secondaryBackgroundColor: Color = .init(hex: 0x1C1C1E)
    public let labelColor: Color = .init(hex: 0xFFFFFF)
    public let secondaryLabelColor: Color = .init(hex: 0xEBEBF5).opacity(0.6)
    public let tertiaryLabelColor: Color = .init(hex: 0xEBEBF5).opacity(0.3)
    public let quaternaryLabelColor: Color = .init(hex: 0xEBEBF5).opacity(0.16)
}

// MARK: - Ocean Breeze Theme
public struct OceanBreezeColorSet: ColorSet {
    public let name: ColorSetName = .oceanBreeze
    public let scheme: ColorScheme = .light
    public let tintColor: Color = .init(hex: 0x00B4D8)
    public let primaryBackgroundColor: Color = .init(hex: 0xF8FDFF)
    public let secondaryBackgroundColor: Color = .init(hex: 0xE6F7FF)
    public let labelColor: Color = .init(hex: 0x1A1A1A)
    public let secondaryLabelColor: Color = .init(hex: 0x4A4A4A)
    public let tertiaryLabelColor: Color = .init(hex: 0x7A7A7A)
    public let quaternaryLabelColor: Color = .init(hex: 0xAAAAA)
}

public struct OceanBreezeDarkColorSet: ColorSet {
    public let name: ColorSetName = .oceanBreezeDark
    public let scheme: ColorScheme = .dark
    public let tintColor: Color = .init(hex: 0x48CAE4)
    public let primaryBackgroundColor: Color = .init(hex: 0x0A1418)
    public let secondaryBackgroundColor: Color = .init(hex: 0x152B33)
    public let labelColor: Color = .init(hex: 0xE6F7FF)
    public let secondaryLabelColor: Color = .init(hex: 0xB5E5F0)
    public let tertiaryLabelColor: Color = .init(hex: 0x84D3E5)
    public let quaternaryLabelColor: Color = .init(hex: 0x53C1DA)
}

// MARK: - Forest Green Theme
public struct ForestGreenColorSet: ColorSet {
    public let name: ColorSetName = .forestGreen
    public let scheme: ColorScheme = .light
    public let tintColor: Color = .init(hex: 0x228B22)
    public let primaryBackgroundColor: Color = .init(hex: 0xFAFFFAA)
    public let secondaryBackgroundColor: Color = .init(hex: 0xF0FFF0)
    public let labelColor: Color = .init(hex: 0x1A2E1A)
    public let secondaryLabelColor: Color = .init(hex: 0x4A6A4A)
    public let tertiaryLabelColor: Color = .init(hex: 0x7AA67A)
    public let quaternaryLabelColor: Color = .init(hex: 0xAAC2AA)
}

public struct ForestGreenDarkColorSet: ColorSet {
    public let name: ColorSetName = .forestGreenDark
    public let scheme: ColorScheme = .dark
    public let tintColor: Color = .init(hex: 0x32CD32)
    public let primaryBackgroundColor: Color = .init(hex: 0x0A1A0A)
    public let secondaryBackgroundColor: Color = .init(hex: 0x1A331A)
    public let labelColor: Color = .init(hex: 0xF0FFF0)
    public let secondaryLabelColor: Color = .init(hex: 0xC2E5C2)
    public let tertiaryLabelColor: Color = .init(hex: 0x94DB94)
    public let quaternaryLabelColor: Color = .init(hex: 0x66D166)
}

// MARK: - Sunset Orange Theme
public struct SunsetOrangeColorSet: ColorSet {
    public let name: ColorSetName = .sunsetOrange
    public let scheme: ColorScheme = .light
    public let tintColor: Color = .init(hex: 0xFF6B35)
    public let primaryBackgroundColor: Color = .init(hex: 0xFFFAF8)
    public let secondaryBackgroundColor: Color = .init(hex: 0xFFF2ED)
    public let labelColor: Color = .init(hex: 0x2E1A14)
    public let secondaryLabelColor: Color = .init(hex: 0x6A4A3A)
    public let tertiaryLabelColor: Color = .init(hex: 0xA67A60)
    public let quaternaryLabelColor: Color = .init(hex: 0xC2AA86)
}

public struct SunsetOrangeDarkColorSet: ColorSet {
    public let name: ColorSetName = .sunsetOrangeDark
    public let scheme: ColorScheme = .dark
    public let tintColor: Color = .init(hex: 0xFF8C69)
    public let primaryBackgroundColor: Color = .init(hex: 0x1A0A05)
    public let secondaryBackgroundColor: Color = .init(hex: 0x33140A)
    public let labelColor: Color = .init(hex: 0xFFF2ED)
    public let secondaryLabelColor: Color = .init(hex: 0xE5C2B3)
    public let tertiaryLabelColor: Color = .init(hex: 0xDB9279)
    public let quaternaryLabelColor: Color = .init(hex: 0xD1623F)
}

// MARK: - Deep Purple Theme
public struct DeepPurpleColorSet: ColorSet {
    public let name: ColorSetName = .deepPurple
    public let scheme: ColorScheme = .light
    public let tintColor: Color = .init(hex: 0x6A4C93)
    public let primaryBackgroundColor: Color = .init(hex: 0xFAF8FF)
    public let secondaryBackgroundColor: Color = .init(hex: 0xF0EDFF)
    public let labelColor: Color = .init(hex: 0x1A142E)
    public let secondaryLabelColor: Color = .init(hex: 0x4A3A6A)
    public let tertiaryLabelColor: Color = .init(hex: 0x7A60A6)
    public let quaternaryLabelColor: Color = .init(hex: 0xAA86C2)
}

public struct DeepPurpleDarkColorSet: ColorSet {
    public let name: ColorSetName = .deepPurpleDark
    public let scheme: ColorScheme = .dark
    public let tintColor: Color = .init(hex: 0x9A7BC8)
    public let primaryBackgroundColor: Color = .init(hex: 0x0A051A)
    public let secondaryBackgroundColor: Color = .init(hex: 0x140A33)
    public let labelColor: Color = .init(hex: 0xF0EDFF)
    public let secondaryLabelColor: Color = .init(hex: 0xC2B3E5)
    public let tertiaryLabelColor: Color = .init(hex: 0x9479DB)
    public let quaternaryLabelColor: Color = .init(hex: 0x663FD1)
}

// MARK: - Charcoal Theme
public struct CharcoalColorSet: ColorSet {
    public let name: ColorSetName = .charcoal
    public let scheme: ColorScheme = .light
    public let tintColor: Color = .init(hex: 0x36454F)
    public let primaryBackgroundColor: Color = .init(hex: 0xF8F9FA)
    public let secondaryBackgroundColor: Color = .init(hex: 0xEDEFF2)
    public let labelColor: Color = .init(hex: 0x1C1E21)
    public let secondaryLabelColor: Color = .init(hex: 0x4C5459)
    public let tertiaryLabelColor: Color = .init(hex: 0x7C8A91)
    public let quaternaryLabelColor: Color = .init(hex: 0xACC0C9)
}

public struct CharcoalDarkColorSet: ColorSet {
    public let name: ColorSetName = .charcoalDark
    public let scheme: ColorScheme = .dark
    public let tintColor: Color = .init(hex: 0x708090)
    public let primaryBackgroundColor: Color = .init(hex: 0x0A0B0C)
    public let secondaryBackgroundColor: Color = .init(hex: 0x1C1E21)
    public let labelColor: Color = .init(hex: 0xEDEFF2)
    public let secondaryLabelColor: Color = .init(hex: 0xC9D6DE)
    public let tertiaryLabelColor: Color = .init(hex: 0xA5BCCA)
    public let quaternaryLabelColor: Color = .init(hex: 0x81A2B6)
}

// MARK: - Available Color Sets
public let availableColorSets: [ColorSet] = [
    ModernBlueColorSet(),
    ModernBlueDarkColorSet(),
    OceanBreezeColorSet(),
    OceanBreezeDarkColorSet(),
    ForestGreenColorSet(),
    ForestGreenDarkColorSet(),
    SunsetOrangeColorSet(),
    SunsetOrangeDarkColorSet(),
    DeepPurpleColorSet(),
    DeepPurpleDarkColorSet(),
    CharcoalColorSet(),
    CharcoalDarkColorSet()
]

// MARK: - Color Set Constants
public let modernBlueColorSet = ModernBlueColorSet()
public let modernBlueDarkColorSet = ModernBlueDarkColorSet()
public let oceanBreezeColorSet = OceanBreezeColorSet()
public let oceanBreezeDarkColorSet = OceanBreezeDarkColorSet()
public let forestGreenColorSet = ForestGreenColorSet()
public let forestGreenDarkColorSet = ForestGreenDarkColorSet()
public let sunsetOrangeColorSet = SunsetOrangeColorSet()
public let sunsetOrangeDarkColorSet = SunsetOrangeDarkColorSet()
public let deepPurpleColorSet = DeepPurpleColorSet()
public let deepPurpleDarkColorSet = DeepPurpleDarkColorSet()
public let charcoalColorSet = CharcoalColorSet()
public let charcoalDarkColorSet = CharcoalDarkColorSet()

// MARK: - Color Extensions
public extension Color {
    init(hex: UInt32) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
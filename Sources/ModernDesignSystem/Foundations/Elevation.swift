//
//  Elevation.swift
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

public struct ElevationToken: Codable, Hashable, Sendable {
    public let shadowColor: ColorToken
    public let shadowRadius: CGFloat
    public let shadowOffset: CGSize
    public let shadowOpacity: CGFloat
    
    public init(shadowColor: ColorToken, shadowRadius: CGFloat, shadowOffset: CGSize, shadowOpacity: CGFloat) {
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.shadowOpacity = shadowOpacity
    }
}

public struct Elevation: Codable, Hashable, Sendable {
    public let none: ElevationToken
    public let xs: ElevationToken
    public let sm: ElevationToken
    public let md: ElevationToken
    public let lg: ElevationToken
    public let xl: ElevationToken
    public let xxl: ElevationToken
    
    public init(none: ElevationToken, xs: ElevationToken, sm: ElevationToken, md: ElevationToken, lg: ElevationToken, xl: ElevationToken, xxl: ElevationToken) {
        self.none = none
        self.xs = xs
        self.sm = sm
        self.md = md
        self.lg = lg
        self.xl = xl
        self.xxl = xxl
    }
}

// MARK: - Default Elevation
public extension Elevation {
    static let modern = Elevation(
        none: ElevationToken(
            shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0),
            shadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 0),
            shadowOpacity: 0
        ),
        xs: ElevationToken(
            shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.1),
            shadowRadius: 2,
            shadowOffset: CGSize(width: 0, height: 1),
            shadowOpacity: 0.1
        ),
        sm: ElevationToken(
            shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.1),
            shadowRadius: 4,
            shadowOffset: CGSize(width: 0, height: 2),
            shadowOpacity: 0.1
        ),
        md: ElevationToken(
            shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.15),
            shadowRadius: 8,
            shadowOffset: CGSize(width: 0, height: 4),
            shadowOpacity: 0.15
        ),
        lg: ElevationToken(
            shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.2),
            shadowRadius: 16,
            shadowOffset: CGSize(width: 0, height: 8),
            shadowOpacity: 0.2
        ),
        xl: ElevationToken(
            shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.25),
            shadowRadius: 24,
            shadowOffset: CGSize(width: 0, height: 12),
            shadowOpacity: 0.25
        ),
        xxl: ElevationToken(
            shadowColor: ColorToken(red: 0, green: 0, blue: 0, opacity: 0.3),
            shadowRadius: 32,
            shadowOffset: CGSize(width: 0, height: 16),
            shadowOpacity: 0.3
        )
    )
}
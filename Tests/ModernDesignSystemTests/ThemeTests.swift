//
//  ThemeTests.swift
//  ModernDesignSystemTests
//
//  Created by Claude on 24/08/2025.
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

@testable import ModernDesignSystem
import SwiftUI
import XCTest

@available(iOS 17.0, *)
final class ThemeTests: XCTestCase {
  func testLightThemeSystem() {
    let theme = Theme.light

    XCTAssertEqual(theme.system, .light)
    XCTAssertEqual(theme.name, "Light")
    XCTAssertEqual(theme.rawValue, "light")
  }

  func testDarkThemeSystem() {
    let theme = Theme.dark

    XCTAssertEqual(theme.system, .dark)
    XCTAssertEqual(theme.name, "Dark")
    XCTAssertEqual(theme.rawValue, "dark")
  }

  func testThemeCaseIterable() {
    let allThemes = Theme.allCases

    XCTAssertEqual(allThemes.count, 2)
    XCTAssertTrue(allThemes.contains(.light))
    XCTAssertTrue(allThemes.contains(.dark))
  }

  func testSystemThemeMappingInit() {
    let mapping = SystemThemeMapping(light: .light, dark: .dark)

    XCTAssertEqual(mapping.light, .light)
    XCTAssertEqual(mapping.dark, .dark)
  }

  func testSystemThemeMappingThemeForLight() {
    let mapping = SystemThemeMapping(light: .light, dark: .dark)

    let result = mapping.theme(.light)

    XCTAssertEqual(result, .light)
  }

  func testSystemThemeMappingThemeForDark() {
    let mapping = SystemThemeMapping(light: .light, dark: .dark)

    let result = mapping.theme(.dark)

    XCTAssertEqual(result, .dark)
  }

  func testDefaultSystemThemeMapping() {
    let defaultMapping = SystemThemeMapping.default

    XCTAssertEqual(defaultMapping.light, .light)
    XCTAssertEqual(defaultMapping.dark, .dark)
  }
}

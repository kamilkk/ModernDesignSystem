//
//  ModernDesignSystemTests.swift
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

import XCTest
import SwiftUI
@testable import ModernDesignSystem

@available(iOS 17.0, *)
final class ModernDesignSystemTests: XCTestCase {
    
    func testInitWithBrand() {
        let brand = Brand.modern
        let foundations = DesignFoundations.modern
        
        let designSystem = ModernDesignSystem(brand: brand, designFoundations: foundations)
        
        XCTAssertEqual(designSystem.brand, brand)
        XCTAssertEqual(designSystem.designFoundations, foundations)
        XCTAssertEqual(designSystem.brands, [brand])
        XCTAssertTrue(designSystem.useSystemTheme)
        XCTAssertEqual(designSystem.selectedColorSet, .modernBlue)
    }
    
    func testInitWithMultipleBrands() {
        let brand1 = Brand.modern
        let brand2 = Brand.modern
        let brands = [brand1, brand2]
        let foundations = DesignFoundations.modern
        
        let designSystem = ModernDesignSystem(brands: brands, designFoundations: foundations)
        
        XCTAssertEqual(designSystem.brand, brand1)
        XCTAssertEqual(designSystem.brands, brands)
        XCTAssertEqual(designSystem.designFoundations, foundations)
    }
    
    @MainActor
    func testCurrentThemeWithSystemMapping() {
        let designSystem = ModernDesignSystem.shared
        designSystem.useSystemTheme = true
        
        let lightTheme = designSystem.currentTheme(with: .light)
        let darkTheme = designSystem.currentTheme(with: .dark)
        
        XCTAssertEqual(lightTheme, .light)
        XCTAssertEqual(darkTheme, .dark)
    }
    
    @MainActor
    func testCurrentThemeWithManualTheme() {
        let designSystem = ModernDesignSystem.shared
        designSystem.useSystemTheme = false
        designSystem.theme = .dark
        
        let themeForLight = designSystem.currentTheme(with: .light)
        let themeForDark = designSystem.currentTheme(with: .dark)
        
        XCTAssertEqual(themeForLight, .dark)
        XCTAssertEqual(themeForDark, .dark)
    }
    
    @MainActor
    func testCurrentSchemeWithSystemMapping() {
        let designSystem = ModernDesignSystem.shared
        designSystem.useSystemTheme = true
        
        let lightScheme = designSystem.currentScheme(with: .light)
        let darkScheme = designSystem.currentScheme(with: .dark)
        
        XCTAssertEqual(lightScheme, .light)
        XCTAssertEqual(darkScheme, .dark)
    }
    
    @MainActor
    func testCurrentSchemeWithManualTheme() {
        let designSystem = ModernDesignSystem.shared
        designSystem.useSystemTheme = false
        designSystem.theme = .light
        
        let schemeForDark = designSystem.currentScheme(with: .dark)
        
        XCTAssertEqual(schemeForDark, .light)
    }
    
    @MainActor
    func testColorResolution() {
        let designSystem = ModernDesignSystem.shared
        let colorPath: ColorPath = \.primary
        
        let color = designSystem.color(colorPath, systemScheme: .light)
        
        XCTAssertNotNil(color)
    }
    
    @MainActor
    func testColorTokenResolution() {
        let designSystem = ModernDesignSystem.shared
        let colorPath: ColorPath = \.primary
        
        let colorToken = designSystem.colorToken(colorPath, systemScheme: .light)
        
        XCTAssertGreaterThan(colorToken.opacity, 0)
    }
    
    @MainActor
    func testNilColorPath() {
        let designSystem = ModernDesignSystem.shared
        
        _ = designSystem.color(nil, systemScheme: .light)
        let colorToken = designSystem.colorToken(nil, systemScheme: .light)
        
        XCTAssertLessThan(colorToken.opacity, 0.001)
    }
    
    @MainActor
    func testFontResolution() {
        let designSystem = ModernDesignSystem.shared
        let fontPath: FontPath = \.titleLarge
        
        let font = designSystem.font(fontPath, verticalSizeClass: .regular, horizontalSizeClass: .regular)
        
        XCTAssertNotNil(font)
    }
    
    @MainActor
    func testUpdateFoundations() {
        let designSystem = ModernDesignSystem.shared
        let newFoundations = DesignFoundations.modern
        
        designSystem.updateFoundations(newFoundations)
        
        XCTAssertEqual(designSystem.designFoundations, newFoundations)
    }
    
    @MainActor
    func testCurrentColorSet() {
        let designSystem = ModernDesignSystem.shared
        designSystem.selectedColorSet = .modernBlue
        
        let colorSet = designSystem.currentColorSet
        
        XCTAssertEqual(colorSet.name, .modernBlue)
    }
    
    @MainActor
    func testApplyColorSet() {
        let designSystem = ModernDesignSystem.shared
        let colorSet = modernBlueColorSet
        
        designSystem.applyColorSet(colorSet)
        
        XCTAssertEqual(designSystem.selectedColorSet, colorSet.name)
    }
}

enum TestError: Error {
    case shouldHaveThrown
}

extension XCTestCase {
    func XCTAssertThrows<T>(_ expression: @autoclosure () throws -> T, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertThrowsError(try expression(), file: file, line: line)
    }
}
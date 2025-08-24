//
//  ColorTokenTests.swift
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
final class ColorTokenTests: XCTestCase {
    
    func testColorTokenInit() {
        let colorToken = ColorToken(red: 0.5, green: 0.7, blue: 0.3, opacity: 0.8)
        
        XCTAssertEqual(colorToken.red, 0.5)
        XCTAssertEqual(colorToken.green, 0.7)
        XCTAssertEqual(colorToken.blue, 0.3)
        XCTAssertEqual(colorToken.opacity, 0.8)
    }
    
    func testColorTokenDefaultOpacity() {
        let colorToken = ColorToken(red: 1.0, green: 0.5, blue: 0.2)
        
        XCTAssertEqual(colorToken.opacity, 1.0)
    }
    
    func testColorTokenColor() {
        let colorToken = ColorToken(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0)
        let color = colorToken.color
        
        XCTAssertNotNil(color)
    }
    
    func testSemanticColorTokenInit() {
        let lightPath: GlobalColorPath = \.primary500
        let darkPath: GlobalColorPath = \.primary600
        
        let semanticToken = SemanticColorToken(light: lightPath, dark: darkPath)
        
        XCTAssertEqual(semanticToken.light, lightPath)
        XCTAssertEqual(semanticToken.dark, darkPath)
    }
    
    func testSemanticColorTokenSubscript() {
        let lightPath: GlobalColorPath = \.primary500
        let darkPath: GlobalColorPath = \.primary600
        let semanticToken = SemanticColorToken(light: lightPath, dark: darkPath)
        
        let lightResult = semanticToken[.light]
        let darkResult = semanticToken[.dark]
        
        XCTAssertEqual(lightResult, lightPath)
        XCTAssertEqual(darkResult, darkPath)
    }
    
    func testSemanticColorTokenPath() {
        let lightPath: GlobalColorPath = \.primary500
        let darkPath: GlobalColorPath = \.primary600
        let semanticToken = SemanticColorToken(light: lightPath, dark: darkPath)
        
        XCTAssertEqual(semanticToken.path, lightPath)
    }
}
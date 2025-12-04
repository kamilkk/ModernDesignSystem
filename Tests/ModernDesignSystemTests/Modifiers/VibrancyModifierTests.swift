//
//  VibrancyModifierTests.swift
//  ModernDesignSystemTests
//
//  Created by Kamil Kowalski on 04/12/2025.
//  Copyright © 2025 Kamil Kowalski. All rights reserved.
//

@testable import ModernDesignSystem
import SwiftUI
import XCTest

@available(iOS 17.0, macOS 14.0, *)
@MainActor
final class VibrancyModifierTests: XCTestCase {
  func testVibrancyModifierInitialization() {
    let modifier = VibrancyModifier()
    XCTAssertNotNil(modifier)
  }

  func testVibrancyModifierWithDefaultIntensity() {
    let modifier = VibrancyModifier()
    XCTAssertEqual(modifier.intensity, 1.0)
  }

  func testVibrancyModifierWithCustomIntensity() {
    let modifier = VibrancyModifier(intensity: 0.5)
    XCTAssertEqual(modifier.intensity, 0.5)
  }

  func testVibrancyModifierWithZeroIntensity() {
    let modifier = VibrancyModifier(intensity: 0.0)
    XCTAssertEqual(modifier.intensity, 0.0)
  }

  func testVibrancyModifierWithMaxIntensity() {
    let modifier = VibrancyModifier(intensity: 1.0)
    XCTAssertEqual(modifier.intensity, 1.0)
  }

  func testVibrancyViewExtension() {
    let view = Text("Test").vibrancy()
    XCTAssertNotNil(view)
  }

  func testVibrancyViewExtensionWithCustomIntensity() {
    let view = Text("Test").vibrancy(intensity: 0.7)
    XCTAssertNotNil(view)
  }

  func testVibrancyIntensityRange() {
    let testValues: [Double] = [0.0, 0.25, 0.5, 0.75, 1.0]
    for intensity in testValues {
      let modifier = VibrancyModifier(intensity: intensity)
      XCTAssertEqual(modifier.intensity, intensity)
    }
  }
}

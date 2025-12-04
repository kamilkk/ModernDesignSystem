//
//  MaterialStylesTests.swift
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
final class MaterialStylesTests: XCTestCase {
  func testMaterialStyleEnumCases() {
    let allCases = MaterialStyle.allCases
    XCTAssertEqual(allCases.count, 4)
    XCTAssertTrue(allCases.contains(.glass))
    XCTAssertTrue(allCases.contains(.frosted))
    XCTAssertTrue(allCases.contains(.subtle))
    XCTAssertTrue(allCases.contains(.prominent))
  }

  func testGlassMaterialStyle() {
    let style = MaterialStyle.glass
    XCTAssertNotNil(style.material)
    XCTAssertEqual(style.opacity, 0.9)
  }

  func testFrostedMaterialStyle() {
    let style = MaterialStyle.frosted
    XCTAssertNotNil(style.material)
    XCTAssertEqual(style.opacity, 0.8)
  }

  func testSubtleMaterialStyle() {
    let style = MaterialStyle.subtle
    XCTAssertNotNil(style.material)
    XCTAssertEqual(style.opacity, 0.5)
  }

  func testProminentMaterialStyle() {
    let style = MaterialStyle.prominent
    XCTAssertNotNil(style.material)
    XCTAssertEqual(style.opacity, 0.95)
  }

  func testMaterialStyleOpacityRange() {
    for style in MaterialStyle.allCases {
      XCTAssertGreaterThanOrEqual(style.opacity, 0.0)
      XCTAssertLessThanOrEqual(style.opacity, 1.0)
    }
  }

  func testMaterialStyleViewModifier() {
    let view = Text("Test").materialStyle(.glass)
    XCTAssertNotNil(view)
  }
}

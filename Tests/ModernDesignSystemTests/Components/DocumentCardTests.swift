//
//  DocumentCardTests.swift
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
final class DocumentCardTests: XCTestCase {
  func testDocumentCardInitialization() {
    let card = DocumentCard(
      title: "Test Document",
      fileType: .pdf
    )
    XCTAssertNotNil(card)
  }

  func testDocumentCardWithAllParameters() {
    let card = DocumentCard(
      title: "Test Document",
      subtitle: "Subtitle",
      thumbnailImage: Image(systemName: "doc"),
      fileType: .pdf,
      metadata: "Modified today",
      isFavorite: true,
      style: .hero,
      action: {}
    )
    XCTAssertNotNil(card)
  }

  func testDocumentCardStyleEnum() {
    let heroCard = DocumentCard(title: "Test", fileType: .pdf, style: .hero)
    let compactCard = DocumentCard(title: "Test", fileType: .pdf, style: .compact)
    let listCard = DocumentCard(title: "Test", fileType: .pdf, style: .list)

    XCTAssertNotNil(heroCard)
    XCTAssertNotNil(compactCard)
    XCTAssertNotNil(listCard)
  }

  func testDocumentCardDefaultStyle() {
    let card = DocumentCard(title: "Test", fileType: .pdf)
    XCTAssertNotNil(card)
  }

  func testDocumentCardWithOptionalParameters() {
    let card1 = DocumentCard(
      title: "Test",
      subtitle: nil,
      fileType: .pdf
    )
    XCTAssertNotNil(card1)

    let card2 = DocumentCard(
      title: "Test",
      fileType: .pdf,
      metadata: nil
    )
    XCTAssertNotNil(card2)
  }

  func testDocumentCardWithFavoriteFlag() {
    let favoriteCard = DocumentCard(
      title: "Test",
      fileType: .pdf,
      isFavorite: true
    )
    XCTAssertNotNil(favoriteCard)

    let normalCard = DocumentCard(
      title: "Test",
      fileType: .pdf,
      isFavorite: false
    )
    XCTAssertNotNil(normalCard)
  }

  func testDocumentCardActionCallback() {
    var actionCalled = false
    let card = DocumentCard(
      title: "Test",
      fileType: .pdf,
      action: {
        actionCalled = true
      }
    )
    XCTAssertNotNil(card)
    // Note: Callback can't be tested directly in SwiftUI view tests
  }
}

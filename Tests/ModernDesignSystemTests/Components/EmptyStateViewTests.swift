//
//  EmptyStateViewTests.swift
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
final class EmptyStateViewTests: XCTestCase {
  func testEmptyStateViewInitialization() {
    let view = EmptyStateView(
      image: Image(systemName: "doc"),
      title: "No Documents"
    )
    XCTAssertNotNil(view)
  }

  func testEmptyStateViewWithAllParameters() {
    let view = EmptyStateView(
      image: Image(systemName: "doc"),
      title: "No Documents",
      subtitle: "Add documents to get started",
      actionTitle: "Open Documents",
      action: {}
    )
    XCTAssertNotNil(view)
  }

  func testEmptyStateViewWithOptionalParameters() {
    let view1 = EmptyStateView(
      image: Image(systemName: "doc"),
      title: "No Documents",
      subtitle: nil,
      actionTitle: nil,
      action: nil
    )
    XCTAssertNotNil(view1)

    let view2 = EmptyStateView(
      image: Image(systemName: "doc"),
      title: "No Documents",
      subtitle: "Subtitle"
    )
    XCTAssertNotNil(view2)
  }

  func testNoDocumentsPreset() {
    let view = EmptyStateView.noDocuments {
      // Action
    }
    XCTAssertNotNil(view)
  }

  func testNoSearchResultsPreset() {
    let view = EmptyStateView.noSearchResults(query: "test")
    XCTAssertNotNil(view)
  }

  func testNoFavoritesPreset() {
    let view = EmptyStateView.noFavorites {
      // Action
    }
    XCTAssertNotNil(view)
  }

  func testNoSearchResultsWithEmptyQuery() {
    let view = EmptyStateView.noSearchResults(query: "")
    XCTAssertNotNil(view)
  }

  func testNoSearchResultsWithLongQuery() {
    let longQuery = "This is a very long search query that might be truncated in the UI"
    let view = EmptyStateView.noSearchResults(query: longQuery)
    XCTAssertNotNil(view)
  }
}

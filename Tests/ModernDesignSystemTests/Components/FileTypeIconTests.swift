//
//  FileTypeIconTests.swift
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
final class FileTypeIconTests: XCTestCase {
  func testFileTypeIconInitialization() {
    let icon = FileTypeIcon(fileType: .pdf, size: 44)
    XCTAssertNotNil(icon)
  }

  func testFileTypeIconDefaultSize() {
    let icon = FileTypeIcon(fileType: .pdf)
    XCTAssertNotNil(icon)
  }

  func testAllFileTypesHaveIcons() {
    for fileType in FileTypeIcon.FileType.allCases {
      let icon = fileType.icon
      XCTAssertFalse(icon.isEmpty, "File type \(fileType) should have an icon")
    }
  }

  func testAllFileTypesHaveColorTokens() {
    for fileType in FileTypeIcon.FileType.allCases {
      let colorToken = fileType.colorToken
      XCTAssertNotNil(colorToken, "File type \(fileType) should have a color token")
    }
  }

  func testPDFFileTypeIcon() {
    let fileType = FileTypeIcon.FileType.pdf
    XCTAssertEqual(fileType.icon, "doc.fill")
    XCTAssertEqual(fileType.colorToken, DocumentTypeColors.pdf)
  }

  func testOfficeFileTypesUseOfficeColor() {
    let wordType = FileTypeIcon.FileType.word
    let excelType = FileTypeIcon.FileType.excel
    let powerpointType = FileTypeIcon.FileType.powerpoint

    XCTAssertEqual(wordType.colorToken, DocumentTypeColors.office)
    XCTAssertEqual(excelType.colorToken, DocumentTypeColors.office)
    XCTAssertEqual(powerpointType.colorToken, DocumentTypeColors.office)
  }

  func testAppleFileTypesUseAppleColor() {
    let pagesType = FileTypeIcon.FileType.pages
    let numbersType = FileTypeIcon.FileType.numbers
    let keynoteType = FileTypeIcon.FileType.keynote

    XCTAssertEqual(pagesType.colorToken, DocumentTypeColors.apple)
    XCTAssertEqual(numbersType.colorToken, DocumentTypeColors.apple)
    XCTAssertEqual(keynoteType.colorToken, DocumentTypeColors.apple)
  }

  func testImageFileTypeUsesImageColor() {
    let imageType = FileTypeIcon.FileType.image
    XCTAssertEqual(imageType.colorToken, DocumentTypeColors.image)
  }

  func testUnknownFileTypeUsesUnknownColor() {
    let unknownType = FileTypeIcon.FileType.unknown
    XCTAssertEqual(unknownType.colorToken, DocumentTypeColors.unknown)
  }

  func testFileTypeRawValues() {
    XCTAssertEqual(FileTypeIcon.FileType.pdf.rawValue, "pdf")
    XCTAssertEqual(FileTypeIcon.FileType.word.rawValue, "word")
    XCTAssertEqual(FileTypeIcon.FileType.excel.rawValue, "excel")
  }
}

//
//  DocumentColors.swift
//  ModernDesignSystem
//
//  Created by Kamil Kowalski on 04/12/2025.
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

// MARK: - Document State Colors

public extension SemanticColors {
  /// Semantic color for newly created/unsaved documents
  static var documentNew: SemanticColorToken {
    SemanticColorToken(
      light: \.primary500,
      dark: \.primary400
    )
  }

  /// Semantic color for modified/unsaved documents
  static var documentModified: SemanticColorToken {
    SemanticColorToken(
      light: \.warning500,
      dark: \.warning400
    )
  }

  /// Semantic color for synced/saved documents
  static var documentSynced: SemanticColorToken {
    SemanticColorToken(
      light: \.success500,
      dark: \.success400
    )
  }

  /// Semantic color for document errors
  static var documentError: SemanticColorToken {
    SemanticColorToken(
      light: \.error500,
      dark: \.error400
    )
  }
}

// MARK: - File Type Category Colors

/// Color tokens for different document file type categories
public enum DocumentTypeColors {
  /// Color for PDF documents
  public nonisolated(unsafe) static let pdf = SemanticColorToken(
    light: \.error500,
    dark: \.error400
  )

  /// Color for Microsoft Office documents (Word, Excel, PowerPoint)
  public nonisolated(unsafe) static let office = SemanticColorToken(
    light: \.primary500,
    dark: \.primary400
  )

  /// Color for Apple iWork documents (Pages, Numbers, Keynote)
  public nonisolated(unsafe) static let apple = SemanticColorToken(
    light: \.secondary500,
    dark: \.secondary400
  )

  /// Color for image files
  public nonisolated(unsafe) static let image = SemanticColorToken(
    light: \.success500,
    dark: \.success400
  )

  /// Color for unknown/generic document types
  public nonisolated(unsafe) static let unknown = SemanticColorToken(
    light: \.neutral500,
    dark: \.neutral500
  )
}

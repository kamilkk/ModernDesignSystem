//
//  FileTypeIcon.swift
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

public struct FileTypeIcon: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  private let fileType: FileType
  private let size: CGFloat

  public init(fileType: FileType, size: CGFloat = 44) {
    self.fileType = fileType
    self.size = size
  }

  public var body: some View {
    ZStack {
      // Gradient background using LinearGradient
      LinearGradient(
        gradient: Gradient(colors: gradientColors),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
      .clipShape(RoundedRectangle(cornerRadius: size * 0.2))

      // SF Symbol icon
      Image(systemName: fileType.icon)
        .font(.system(size: size * 0.5))
        .foregroundColor(.white)
    }
    .frame(width: size, height: size)
    .shadow(
      color: Color.black.opacity(0.1),
      radius: 2,
      x: 0,
      y: 1
    )
  }

  private var gradientColors: [Color] {
    let token = fileType.colorToken
    let theme = designSystem.currentTheme(with: colorScheme)
    let globalColorPath = token[theme]
    let baseColor = designSystem.designFoundations.globalColors[keyPath: globalColorPath].color
    return [
      baseColor,
      baseColor.opacity(0.7),
    ]
  }
}

public extension FileTypeIcon {
  enum FileType: String, CaseIterable, Sendable {
    case pdf
    case word
    case excel
    case powerpoint
    case pages
    case numbers
    case keynote
    case image
    case unknown

    var icon: String {
      switch self {
      case .pdf:
        return "doc.fill"
      case .word:
        return "doc.text.fill"
      case .excel:
        return "tablecells.fill"
      case .powerpoint:
        return "rectangle.on.rectangle.angled"
      case .pages:
        return "doc.richtext.fill"
      case .numbers:
        return "number.square.fill"
      case .keynote:
        return "play.rectangle.fill"
      case .image:
        return "photo.fill"
      case .unknown:
        return "doc.fill"
      }
    }

    var colorToken: SemanticColorToken {
      switch self {
      case .pdf:
        return DocumentTypeColors.pdf
      case .word, .excel, .powerpoint:
        return DocumentTypeColors.office
      case .pages, .numbers, .keynote:
        return DocumentTypeColors.apple
      case .image:
        return DocumentTypeColors.image
      case .unknown:
        return DocumentTypeColors.unknown
      }
    }
  }
}

// MARK: - Previews

#if DEBUG
  @available(iOS 17.0, macOS 14.0, *)
  #Preview {
    ScrollView {
      VStack(spacing: 24) {
        Text("File Type Icons")
          .font(.title)
          .fontWeight(.bold)

        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 16) {
          ForEach(FileTypeIcon.FileType.allCases, id: \.self) { type in
            VStack(spacing: 8) {
              FileTypeIcon(fileType: type)
              Text(type.rawValue.capitalized)
                .font(.caption)
            }
          }
        }
        .padding()
      }
      .padding()
    }
    .environmentObject(ModernDesignSystem.shared)
  }
#endif

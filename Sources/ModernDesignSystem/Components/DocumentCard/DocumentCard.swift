//
//  DocumentCard.swift
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

public struct DocumentCard: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  private let title: String
  private let subtitle: String?
  private let thumbnailImage: Image?
  private let fileType: FileTypeIcon.FileType
  private let metadata: String?
  private let isFavorite: Bool
  private let style: Style
  private let action: () -> Void

  public init(
    title: String,
    subtitle: String? = nil,
    thumbnailImage: Image? = nil,
    fileType: FileTypeIcon.FileType,
    metadata: String? = nil,
    isFavorite: Bool = false,
    style: Style = .compact,
    action: @escaping () -> Void = {}
  ) {
    self.title = title
    self.subtitle = subtitle
    self.thumbnailImage = thumbnailImage
    self.fileType = fileType
    self.metadata = metadata
    self.isFavorite = isFavorite
    self.style = style
    self.action = action
  }

  public var body: some View {
    Group {
      switch style {
      case .hero:
        heroLayout
      case .compact:
        compactLayout
      case .list:
        listLayout
      }
    }
    .onTapGesture {
      action()
    }
  }

  // MARK: - Hero Layout (Full-width, rich metadata)

  private var heroLayout: some View {
    ModernCard(elevation: .medium) {
      VStack(alignment: .leading, spacing: designSystem.brand.spacing.lg) {
        // Thumbnail section
        if let thumbnailImage = thumbnailImage {
          thumbnailImage
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200)
            .clipped()
        } else {
          defaultThumbnailView(height: 200)
        }

        // Content section
        VStack(alignment: .leading, spacing: designSystem.brand.spacing.sm) {
          HStack(spacing: designSystem.brand.spacing.sm) {
            FileTypeIcon(fileType: fileType, size: 32)

            VStack(alignment: .leading, spacing: designSystem.brand.spacing.xs) {
              Text(title)
                .font(designSystem.brand.typography.titleLarge.font(
                  verticalSizeClass: nil,
                  horizontalSizeClass: nil
                ))
                .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))
                .lineLimit(2)

              if let subtitle = subtitle {
                Text(subtitle)
                  .font(designSystem.brand.typography.bodyMedium.font(
                    verticalSizeClass: nil,
                    horizontalSizeClass: nil
                  ))
                  .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))
                  .lineLimit(1)
              }
            }

            Spacer()

            if isFavorite {
              favoriteIcon
            }
          }

          if let metadata = metadata {
            Text(metadata)
              .font(designSystem.brand.typography.captionMedium.font(
                verticalSizeClass: nil,
                horizontalSizeClass: nil
              ))
              .foregroundColor(designSystem.color(\.tertiaryText, systemScheme: colorScheme))
          }
        }
      }
    }
  }

  // MARK: - Compact Layout (Grid cell)

  private var compactLayout: some View {
    ModernCard(elevation: .low, padding: EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)) {
      VStack(alignment: .leading, spacing: designSystem.brand.spacing.md) {
        // Thumbnail section
        ZStack(alignment: .topTrailing) {
          if let thumbnailImage = thumbnailImage {
            thumbnailImage
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(height: 120)
              .clipped()
              .clipShape(RoundedRectangle(cornerRadius: 8))
          } else {
            defaultThumbnailView(height: 120)
          }

          if isFavorite {
            favoriteIcon
              .padding(8)
          }
        }

        // Content section
        VStack(alignment: .leading, spacing: designSystem.brand.spacing.xs) {
          HStack(spacing: designSystem.brand.spacing.sm) {
            FileTypeIcon(fileType: fileType, size: 24)

            Text(title)
              .font(designSystem.brand.typography.titleSmall.font(
                verticalSizeClass: nil,
                horizontalSizeClass: nil
              ))
              .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))
              .lineLimit(1)
          }

          if let metadata = metadata {
            Text(metadata)
              .font(designSystem.brand.typography.captionSmall.font(
                verticalSizeClass: nil,
                horizontalSizeClass: nil
              ))
              .foregroundColor(designSystem.color(\.tertiaryText, systemScheme: colorScheme))
              .lineLimit(1)
          }
        }
      }
    }
  }

  // MARK: - List Layout (Row)

  private var listLayout: some View {
    ModernCard(elevation: .none, padding: EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)) {
      HStack(spacing: designSystem.brand.spacing.md) {
        // Thumbnail
        if let thumbnailImage = thumbnailImage {
          thumbnailImage
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
          FileTypeIcon(fileType: fileType, size: 60)
        }

        // Content
        VStack(alignment: .leading, spacing: designSystem.brand.spacing.xs) {
          Text(title)
            .font(designSystem.brand.typography.titleMedium.font(
              verticalSizeClass: nil,
              horizontalSizeClass: nil
            ))
            .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))
            .lineLimit(1)

          if let subtitle = subtitle {
            Text(subtitle)
              .font(designSystem.brand.typography.bodySmall.font(
                verticalSizeClass: nil,
                horizontalSizeClass: nil
              ))
              .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))
              .lineLimit(1)
          }

          if let metadata = metadata {
            Text(metadata)
              .font(designSystem.brand.typography.captionSmall.font(
                verticalSizeClass: nil,
                horizontalSizeClass: nil
              ))
              .foregroundColor(designSystem.color(\.tertiaryText, systemScheme: colorScheme))
              .lineLimit(1)
          }
        }

        Spacer()

        VStack(spacing: designSystem.brand.spacing.sm) {
          if isFavorite {
            favoriteIcon
          }

          Image(systemName: "chevron.right")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(designSystem.color(\.tertiaryText, systemScheme: colorScheme))
        }
      }
    }
  }

  // MARK: - Helper Views

  private func defaultThumbnailView(height: CGFloat) -> some View {
    ZStack {
      designSystem.color(\.secondaryBackground, systemScheme: colorScheme)

      FileTypeIcon(fileType: fileType, size: height * 0.3)
    }
    .frame(height: height)
    .clipShape(RoundedRectangle(cornerRadius: 8))
  }

  private var favoriteIcon: some View {
    Image(systemName: "star.fill")
      .font(.system(size: 16))
      .foregroundColor(designSystem.color(\.warning, systemScheme: colorScheme))
  }
}

// MARK: - Style Enum

public extension DocumentCard {
  enum Style: Sendable {
    case hero // Large, full-width with rich metadata
    case compact // Grid cell with thumbnail and title
    case list // Row layout for list view
  }
}

// MARK: - Previews

#if DEBUG
  @available(iOS 17.0, macOS 14.0, *)
  #Preview {
    ScrollView {
      VStack(spacing: 24) {
        Text("Document Card Styles")
          .font(.title)
          .fontWeight(.bold)

        // Hero style
        DocumentCard(
          title: "Project Proposal 2025.pdf",
          subtitle: "Important project documentation",
          fileType: .pdf,
          metadata: "Modified 2 hours ago • 2.5 MB",
          isFavorite: true,
          style: .hero
        )

        // Compact grid
        HStack(spacing: 16) {
          DocumentCard(
            title: "Budget.xlsx",
            fileType: .excel,
            metadata: "12.3 MB",
            style: .compact
          )

          DocumentCard(
            title: "Presentation.pptx",
            fileType: .powerpoint,
            metadata: "8.1 MB",
            isFavorite: true,
            style: .compact
          )
        }

        // List style
        VStack(spacing: 8) {
          DocumentCard(
            title: "Meeting Notes.pages",
            subtitle: "Team sync notes",
            fileType: .pages,
            metadata: "Today at 3:42 PM",
            style: .list
          )

          DocumentCard(
            title: "Financial Report.numbers",
            subtitle: "Q4 2025",
            fileType: .numbers,
            metadata: "Yesterday",
            isFavorite: true,
            style: .list
          )
        }
      }
      .padding()
    }
    .environmentObject(ModernDesignSystem.shared)
  }
#endif

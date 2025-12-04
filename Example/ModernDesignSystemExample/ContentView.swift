//
//  ContentView.swift
//  ModernDesignSystemDemo
//
//  Created by Kamil Kowalski on 19/08/2025.
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

import ModernDesignSystem
import SwiftUI

struct ContentView: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @State private var selectedTab: Tab = .components
  @State private var selectedColorSet: ColorSetName = .modernBlue

  var body: some View {
    Group {
      if horizontalSizeClass == .compact {
        // iPhone - use TabView
        TabView(selection: $selectedTab) {
          ForEach(Tab.allCases, id: \.self) { tab in
            NavigationView {
              tabContentView(for: tab)
                .navigationTitle(tab.title)
              #if os(iOS)
                .navigationBarTitleDisplayMode(.large)
              #endif
                .toolbar {
                  ToolbarItem(placement: .primaryAction) {
                    NavigationLink("Settings") {
                      settingsView
                        .navigationTitle("Settings")
                      #if os(iOS)
                        .navigationBarTitleDisplayMode(.inline)
                      #endif
                    }
                  }
                }
            }
            .tabItem {
              Label(tab.title, systemImage: tab.icon)
            }
            .tag(tab)
          }
        }
      } else {
        // iPad/macOS - use NavigationSplitView
        NavigationSplitView {
          sidebar
        } detail: {
          detailView
        }
        #if os(macOS)
        .navigationSplitViewColumnWidth(min: 250, ideal: 300)
        #endif
      }
    }
    .background(designSystem.color(\.primaryBackground, systemScheme: colorScheme))
    .onAppear {
      selectedColorSet = designSystem.selectedColorSet
    }
    .onChange(of: selectedColorSet) { _, newValue in
      if let colorSet = availableColorSets.first(where: { $0.name == newValue }) {
        designSystem.applyColorSet(colorSet)
      }
    }
  }

  @ViewBuilder
  private var sidebar: some View {
    List {
      Section("Design System") {
        ForEach(Tab.allCases, id: \.self) { tab in
          Button(action: {
            selectedTab = tab
          }) {
            HStack {
              Label(tab.title, systemImage: tab.icon)
              Spacer()
              if selectedTab == tab {
                Image(systemName: "checkmark")
                  .foregroundColor(.accentColor)
              }
            }
          }
          .buttonStyle(.plain)
          .foregroundColor(selectedTab == tab ? .accentColor : .primary)
        }
      }

      Section("Theme") {
        Picker("Color Set", selection: $selectedColorSet) {
          ForEach(ColorSetName.allCases, id: \.self) { colorSet in
            Text(colorSet.rawValue)
              .tag(colorSet)
          }
        }
        .pickerStyle(.menu)

        Toggle("Use System Theme", isOn: $designSystem.useSystemTheme)

        if !designSystem.useSystemTheme {
          Picker("Theme", selection: $designSystem.theme) {
            ForEach(Theme.allCases, id: \.self) { theme in
              Text(theme.name)
                .tag(theme)
            }
          }
          .pickerStyle(.segmented)
        }
      }
    }
    .navigationTitle("Modern Design System")
  }

  @ViewBuilder
  private func tabContentView(for tab: Tab) -> some View {
    Group {
      switch tab {
      case .components:
        ComponentsView()
      case .colors:
        ColorsView()
      case .typography:
        TypographyView()
      case .spacing:
        SpacingView()
      case .examples:
        ExamplesView()
      case .iconGenerator:
        AppIconGeneratorView()
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(designSystem.color(\.primaryBackground, systemScheme: colorScheme))
  }

  @ViewBuilder
  private var settingsView: some View {
    Form {
      Section("Theme") {
        Picker("Color Set", selection: $selectedColorSet) {
          ForEach(ColorSetName.allCases, id: \.self) { colorSet in
            Text(colorSet.rawValue)
              .tag(colorSet)
          }
        }
        .pickerStyle(.menu)

        Toggle("Use System Theme", isOn: $designSystem.useSystemTheme)

        if !designSystem.useSystemTheme {
          Picker("Theme", selection: $designSystem.theme) {
            ForEach(Theme.allCases, id: \.self) { theme in
              Text(theme.name)
                .tag(theme)
            }
          }
          .pickerStyle(.segmented)
        }
      }
    }
  }

  @ViewBuilder
  private var detailView: some View {
    Group {
      switch selectedTab {
      case .components:
        ComponentsView()
      case .colors:
        ColorsView()
      case .typography:
        TypographyView()
      case .spacing:
        SpacingView()
      case .examples:
        ExamplesView()
      case .iconGenerator:
        AppIconGeneratorView()
      }
    }
    .navigationTitle(selectedTab.title)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(designSystem.color(\.primaryBackground, systemScheme: colorScheme))
  }
}

enum Tab: String, CaseIterable, Sendable {
  case components = "Components"
  case colors = "Colors"
  case typography = "Typography"
  case spacing = "Spacing"
  case examples = "Examples"
  case iconGenerator = "Icon Generator"

  var title: String {
    rawValue
  }

  var icon: String {
    switch self {
    case .components:
      return "square.stack.3d.up"
    case .colors:
      return "paintbrush"
    case .typography:
      return "textformat"
    case .spacing:
      return "ruler"
    case .examples:
      return "app.gift"
    case .iconGenerator:
      return "app.badge"
    }
  }
}

// MARK: - Component Views

struct ComponentsView: View {
  @EnvironmentObject var designSystem: ModernDesignSystem

  var body: some View {
    ScrollView {
      LazyVStack(spacing: 32) {
        ButtonsDemo()
        TextFieldsDemo()
        LoaderDemo()
        NotificationsDemo()
        CardsDemo()
        DocumentCardsDemo()
        FileTypeIconsDemo()
        EmptyStatesDemo()
        MaterialEffectsDemo()
      }
      .padding()
    }
  }
}

struct ButtonsDemo: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Buttons")
        .font(.title2)
        .fontWeight(.semibold)

      VStack(spacing: 12) {
        HStack(spacing: 12) {
          Button("Primary") {}
            .buttonStyle(ModernButtonStyle(type: .primary))

          Button("Secondary") {}
            .buttonStyle(ModernButtonStyle(type: .secondary))

          Button("Tertiary") {}
            .buttonStyle(ModernButtonStyle(type: .tertiary))
        }

        HStack(spacing: 12) {
          Button("Small") {}
            .buttonStyle(ModernButtonStyle(size: .small))

          Button("Medium") {}
            .buttonStyle(ModernButtonStyle(size: .medium))

          Button("Large") {}
            .buttonStyle(ModernButtonStyle(size: .large))
        }

        Button("Destructive") {}
          .buttonStyle(ModernButtonStyle(type: .destructive))

        Button("Disabled") {}
          .buttonStyle(ModernButtonStyle(type: .primary))
          .disabled(true)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct TextFieldsDemo: View {
  @State private var textInput = ""
  @State private var emailInput = ""
  @State private var passwordInput = ""
  @State private var multilineInput = ""

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Text Fields")
        .font(.title2)
        .fontWeight(.semibold)

      VStack(spacing: 16) {
        ModernTextField("Name", text: $textInput, placeholder: "Enter your name")

        ModernTextField("Email", text: $emailInput, placeholder: "Enter your email", type: .email, helperText: "We'll never share your email")

        ModernTextField("Password", text: $passwordInput, placeholder: "Enter your password", type: .password)

        ModernTextField("Comments", text: $multilineInput, placeholder: "Enter your comments", type: .multiline, helperText: "Optional feedback")

        ModernTextField("Error Example", text: .constant("Invalid input"), placeholder: "This has an error", isError: true, helperText: "This field contains an error")
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct LoaderDemo: View {
  @State private var showOverlayLoader = false
  @State private var showInlineLoader = false
  @State private var showLoadingContent = false

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Loaders")
        .font(.title2)
        .fontWeight(.semibold)

      VStack(spacing: 16) {
        // Different sizes
        VStack(alignment: .leading, spacing: 12) {
          Text("Sizes")
            .font(.headline)

          HStack(spacing: 20) {
            VStack(spacing: 8) {
              ModernLoader(size: .small)
              Text("Small")
                .font(.caption)
            }

            VStack(spacing: 8) {
              ModernLoader(size: .medium)
              Text("Medium")
                .font(.caption)
            }

            VStack(spacing: 8) {
              ModernLoader(size: .large)
              Text("Large")
                .font(.caption)
            }
          }
        }

        Divider()

        // Different colors
        VStack(alignment: .leading, spacing: 12) {
          Text("Colors")
            .font(.headline)

          HStack(spacing: 20) {
            VStack(spacing: 8) {
              ModernLoader(color: .primary)
              Text("Primary")
                .font(.caption)
            }

            VStack(spacing: 8) {
              ModernLoader(color: .secondary)
              Text("Secondary")
                .font(.caption)
            }

            VStack(spacing: 8) {
              ModernLoader(color: .accent)
              Text("Accent")
                .font(.caption)
            }
          }
        }

        Divider()

        // Interactive examples
        VStack(alignment: .leading, spacing: 12) {
          Text("Interactive Examples")
            .font(.headline)

          VStack(spacing: 12) {
            Button(showOverlayLoader ? "Hide Overlay Loader" : "Show Overlay Loader") {
              showOverlayLoader.toggle()
            }
            .buttonStyle(ModernButtonStyle(type: .secondary))

            Button(showInlineLoader ? "Hide Content Loader" : "Show Content Loader") {
              showInlineLoader.toggle()
            }
            .buttonStyle(ModernButtonStyle(type: .secondary))

            Button("Simulate Loading Content") {
              showLoadingContent = true
              DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showLoadingContent = false
              }
            }
            .buttonStyle(ModernButtonStyle(type: .primary))
          }

          // Content with inline loader
          ModernCard {
            VStack(spacing: 12) {
              Text("Sample Content")
                .font(.headline)

              if showInlineLoader {
                VStack(spacing: 12) {
                  ModernLoader()
                  Text("Loading...")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
              } else {
                Text("This content can show a loader when needed. Toggle the button above to see the loader in action.")
                  .font(.body)
                  .foregroundColor(.secondary)
                  .multilineTextAlignment(.center)
              }
            }
          }
          .loader(showLoadingContent, color: .primary, size: .large)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .loader(showOverlayLoader)
  }
}

struct NotificationsDemo: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Notifications")
        .font(.title2)
        .fontWeight(.semibold)

      VStack(spacing: 12) {
        ModernNotification(
          type: .info,
          title: "Information",
          message: "This is an informational message.",
          action: {},
          actionTitle: "Learn More",
          onDismiss: {}
        )

        ModernNotification(
          type: .success,
          title: "Success",
          message: "Your action was completed successfully.",
          onDismiss: {}
        )

        ModernNotification(
          type: .warning,
          title: "Warning",
          message: "Please review your input before proceeding."
        )

        ModernNotification(
          type: .error,
          title: "Error",
          message: "Something went wrong. Please try again.",
          action: {},
          actionTitle: "Retry"
        )
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct CardsDemo: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Cards")
        .font(.title2)
        .fontWeight(.semibold)

      VStack(spacing: 16) {
        InfoCard(
          title: "Settings",
          subtitle: "Manage your preferences and configuration",
          image: "gear",
          action: {}
        )

        ProductCard(
          title: "Modern Design System",
          description: "A comprehensive design system for modern applications with beautiful components and flexible theming.",
          price: "$99.99",
          action: {}
        )

        ModernCard(elevation: .high) {
          VStack(spacing: 12) {
            Image(systemName: "sparkles")
              .font(.system(size: 32))
              .foregroundColor(.purple)

            Text("Custom Card")
              .font(.title3)
              .fontWeight(.semibold)

            Text("This is a custom card with high elevation and custom content")
              .font(.body)
              .foregroundColor(.secondary)
              .multilineTextAlignment(.center)
          }
          .padding()
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct DocumentCardsDemo: View {
  @State private var selectedStyle: DocumentCard.Style = .hero

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Document Cards")
        .font(.title2)
        .fontWeight(.semibold)

      // Style picker
      Picker("Style", selection: $selectedStyle) {
        Text("Hero").tag(DocumentCard.Style.hero)
        Text("Compact").tag(DocumentCard.Style.compact)
        Text("List").tag(DocumentCard.Style.list)
      }
      .pickerStyle(.segmented)
      .padding(.bottom, 8)

      // Style-specific layout
      Group {
        switch selectedStyle {
        case .hero:
          VStack(spacing: 16) {
            DocumentCard(
              title: "Project Proposal 2025.pdf",
              subtitle: "Important project documentation",
              fileType: .pdf,
              metadata: "Modified 2 hours ago • 2.5 MB",
              isFavorite: true,
              style: .hero
            )

            DocumentCard(
              title: "Annual Budget.xlsx",
              subtitle: "Financial planning spreadsheet",
              fileType: .excel,
              metadata: "Today at 10:30 AM • 4.1 MB",
              style: .hero
            )
          }

        case .compact:
          LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
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

            DocumentCard(
              title: "Report.pdf",
              fileType: .pdf,
              metadata: "2.5 MB",
              style: .compact
            )

            DocumentCard(
              title: "Photo.jpg",
              fileType: .image,
              metadata: "1.8 MB",
              isFavorite: true,
              style: .compact
            )
          }

        case .list:
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

            DocumentCard(
              title: "Slides.keynote",
              subtitle: "Company presentation",
              fileType: .keynote,
              metadata: "Dec 1",
              style: .list
            )

            DocumentCard(
              title: "Contract.pdf",
              subtitle: "Legal document",
              fileType: .pdf,
              metadata: "Nov 28",
              style: .list
            )
          }
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct FileTypeIconsDemo: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme
  @State private var iconSize: CGFloat = 44

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("File Type Icons")
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

      VStack(spacing: 12) {
        HStack {
          Text("Icon Size: \(Int(iconSize))pt")
            .font(.caption)
            .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))

          Spacer()
        }

        Slider(value: $iconSize, in: 24 ... 80, step: 4)
          .padding(.bottom, 8)
      }

      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
        ForEach(FileTypeIcon.FileType.allCases, id: \.self) { type in
          VStack(spacing: 8) {
            FileTypeIcon(fileType: type, size: iconSize)

            Text(type.rawValue.capitalized)
              .font(.caption)
              .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))
          }
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct EmptyStatesDemo: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme
  @State private var selectedPreset: EmptyStatePreset = .noDocuments

  enum EmptyStatePreset: String, CaseIterable {
    case noDocuments = "No Documents"
    case noSearchResults = "No Search Results"
    case noFavorites = "No Favorites"
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Empty States")
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

      Picker("Preset", selection: $selectedPreset) {
        ForEach(EmptyStatePreset.allCases, id: \.self) { preset in
          Text(preset.rawValue).tag(preset)
        }
      }
      .pickerStyle(.segmented)

      ModernCard {
        Group {
          switch selectedPreset {
          case .noDocuments:
            EmptyStateView.noDocuments {
              print("Open documents tapped")
            }
            .frame(height: 300)

          case .noSearchResults:
            EmptyStateView.noSearchResults(query: "budget 2025")
              .frame(height: 300)

          case .noFavorites:
            EmptyStateView.noFavorites {
              print("Browse documents tapped")
            }
            .frame(height: 300)
          }
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct MaterialEffectsDemo: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme
  @State private var selectedMaterial: MaterialStyle = .glass
  @State private var vibrancyIntensity: Double = 1.0

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Material Effects")
        .font(.title2)
        .fontWeight(.semibold)

      VStack(spacing: 16) {
        Picker("Material Style", selection: $selectedMaterial) {
          ForEach(MaterialStyle.allCases, id: \.self) { style in
            Text(styleDisplayName(for: style)).tag(style)
          }
        }
        .pickerStyle(.segmented)

        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Text("Vibrancy Intensity: \(Int(vibrancyIntensity * 100))%")
              .font(.caption)
              .foregroundColor(.secondary)

            Spacer()
          }

          Slider(value: $vibrancyIntensity, in: 0 ... 1, step: 0.1)
        }

        // Material effect preview
        ZStack {
          // Background gradient
          LinearGradient(
            gradient: Gradient(colors: [
              designSystem.color(\.primary, systemScheme: colorScheme),
              designSystem.color(\.secondary, systemScheme: colorScheme),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
          .frame(height: 200)
          .clipShape(RoundedRectangle(cornerRadius: 12))

          // Material overlay with content
          VStack(spacing: 12) {
            Image(systemName: "sparkles")
              .font(.system(size: 40))
              .vibrancy(intensity: vibrancyIntensity)

            Text("Material Effect")
              .font(designSystem.brand.typography.titleLarge.font(
                verticalSizeClass: nil,
                horizontalSizeClass: nil
              ))
              .vibrancy(intensity: vibrancyIntensity)

            Text("This content sits on a material background")
              .font(designSystem.brand.typography.bodyMedium.font(
                verticalSizeClass: nil,
                horizontalSizeClass: nil
              ))
              .multilineTextAlignment(.center)
              .vibrancy(intensity: vibrancyIntensity)
          }
          .padding()
          .frame(maxWidth: .infinity)
          .materialStyle(selectedMaterial)
          .clipShape(RoundedRectangle(cornerRadius: 12))
          .padding()
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private func styleDisplayName(for style: MaterialStyle) -> String {
    switch style {
    case .glass: return "Glass"
    case .frosted: return "Frosted"
    case .subtle: return "Subtle"
    case .prominent: return "Prominent"
    }
  }
}

struct ColorsView: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    ScrollView {
      LazyVStack(spacing: 24) {
        colorSetsSection
        semanticColorsSection
        documentStateColorsSection
        fileTypeColorsSection
      }
      .padding()
    }
  }

  @ViewBuilder
  private var colorSetsSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Available Color Sets")
        .font(.title2)
        .fontWeight(.semibold)

      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
        ForEach(availableColorSets.indices, id: \.self) { index in
          let colorSet = availableColorSets[index]
          ColorSetPreview(colorSet: colorSet)
        }
      }
    }
  }

  @ViewBuilder
  private var semanticColorsSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Semantic Colors")
        .font(.title2)
        .fontWeight(.semibold)

      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
        ColorSwatch(name: "Primary Text", color: designSystem.color(\.primaryText, systemScheme: colorScheme))
        ColorSwatch(name: "Secondary Text", color: designSystem.color(\.secondaryText, systemScheme: colorScheme))
        ColorSwatch(name: "Primary", color: designSystem.color(\.primary, systemScheme: colorScheme))
        ColorSwatch(name: "Secondary", color: designSystem.color(\.secondary, systemScheme: colorScheme))
        ColorSwatch(name: "Success", color: designSystem.color(\.success, systemScheme: colorScheme))
        ColorSwatch(name: "Warning", color: designSystem.color(\.warning, systemScheme: colorScheme))
        ColorSwatch(name: "Error", color: designSystem.color(\.error, systemScheme: colorScheme))
        ColorSwatch(name: "Primary Background", color: designSystem.color(\.primaryBackground, systemScheme: colorScheme))
        ColorSwatch(name: "Secondary Background", color: designSystem.color(\.secondaryBackground, systemScheme: colorScheme))
      }
    }
  }

  @ViewBuilder
  private var documentStateColorsSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Document State Colors")
        .font(.title2)
        .fontWeight(.semibold)

      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
        ColorSwatch(name: "Document New", color: resolveDocumentColor(SemanticColors.documentNew))
        ColorSwatch(name: "Document Modified", color: resolveDocumentColor(SemanticColors.documentModified))
        ColorSwatch(name: "Document Synced", color: resolveDocumentColor(SemanticColors.documentSynced))
        ColorSwatch(name: "Document Error", color: resolveDocumentColor(SemanticColors.documentError))
      }
    }
  }

  private func resolveDocumentColor(_ token: SemanticColorToken) -> Color {
    let theme = designSystem.currentTheme(with: colorScheme)
    let globalColorPath = token[theme]
    return designSystem.designFoundations.globalColors[keyPath: globalColorPath].color
  }

  @ViewBuilder
  private var fileTypeColorsSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("File Type Colors")
        .font(.title2)
        .fontWeight(.semibold)

      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
        VStack(spacing: 8) {
          FileTypeIcon(fileType: .pdf, size: 48)
          Text("PDF")
            .font(.caption)
        }

        VStack(spacing: 8) {
          FileTypeIcon(fileType: .word, size: 48)
          Text("Word")
            .font(.caption)
        }

        VStack(spacing: 8) {
          FileTypeIcon(fileType: .excel, size: 48)
          Text("Excel")
            .font(.caption)
        }

        VStack(spacing: 8) {
          FileTypeIcon(fileType: .powerpoint, size: 48)
          Text("PowerPoint")
            .font(.caption)
        }

        VStack(spacing: 8) {
          FileTypeIcon(fileType: .pages, size: 48)
          Text("Pages")
            .font(.caption)
        }

        VStack(spacing: 8) {
          FileTypeIcon(fileType: .numbers, size: 48)
          Text("Numbers")
            .font(.caption)
        }

        VStack(spacing: 8) {
          FileTypeIcon(fileType: .keynote, size: 48)
          Text("Keynote")
            .font(.caption)
        }

        VStack(spacing: 8) {
          FileTypeIcon(fileType: .image, size: 48)
          Text("Image")
            .font(.caption)
        }

        VStack(spacing: 8) {
          FileTypeIcon(fileType: .unknown, size: 48)
          Text("Unknown")
            .font(.caption)
        }
      }
    }
  }
}

struct ColorSetPreview: View {
  let colorSet: ColorSet
  @EnvironmentObject var designSystem: ModernDesignSystem

  var body: some View {
    VStack(spacing: 8) {
      RoundedRectangle(cornerRadius: 8)
        .fill(colorSet.tintColor)
        .frame(height: 60)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(colorSet.quaternaryLabelColor.opacity(0.2), lineWidth: 1)
        )

      Text(colorSet.name.rawValue)
        .font(.caption)
        .foregroundColor(colorSet.labelColor)
    }
    .padding(8)
    .background(colorSet.primaryBackgroundColor)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .overlay(
      RoundedRectangle(cornerRadius: 12)
        .stroke(designSystem.currentColorSet.name == colorSet.name ? colorSet.tintColor : Color.clear, lineWidth: 2)
    )
    .onTapGesture {
      designSystem.applyColorSet(colorSet)
    }
  }
}

struct ColorSwatch: View {
  let name: String
  let color: Color

  var body: some View {
    VStack(spacing: 8) {
      RoundedRectangle(cornerRadius: 8)
        .fill(color)
        .frame(height: 40)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )

      Text(name)
        .font(.caption2)
        .multilineTextAlignment(.center)
    }
  }
}

struct TypographyView: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        typographySection("Display", tokens: [
          ("Display Large", designSystem.brand.typography.displayLarge),
          ("Display Medium", designSystem.brand.typography.displayMedium),
          ("Display Small", designSystem.brand.typography.displaySmall),
        ])

        typographySection("Headlines", tokens: [
          ("Headline Large", designSystem.brand.typography.headlineLarge),
          ("Headline Medium", designSystem.brand.typography.headlineMedium),
          ("Headline Small", designSystem.brand.typography.headlineSmall),
        ])

        typographySection("Titles", tokens: [
          ("Title Large", designSystem.brand.typography.titleLarge),
          ("Title Medium", designSystem.brand.typography.titleMedium),
          ("Title Small", designSystem.brand.typography.titleSmall),
        ])

        typographySection("Body", tokens: [
          ("Body Large", designSystem.brand.typography.bodyLarge),
          ("Body Medium", designSystem.brand.typography.bodyMedium),
          ("Body Small", designSystem.brand.typography.bodySmall),
        ])

        typographySection("Labels", tokens: [
          ("Label Large", designSystem.brand.typography.labelLarge),
          ("Label Medium", designSystem.brand.typography.labelMedium),
          ("Label Small", designSystem.brand.typography.labelSmall),
        ])
      }
      .padding()
    }
  }

  @ViewBuilder
  private func typographySection(_ title: String, tokens: [(String, FontToken)]) -> some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(title)
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

      VStack(alignment: .leading, spacing: 12) {
        ForEach(tokens.indices, id: \.self) { index in
          let (name, token) = tokens[index]
          VStack(alignment: .leading, spacing: 4) {
            Text(name)
              .font(token.font(verticalSizeClass: nil, horizontalSizeClass: nil))
              .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

            Text("Size: \(Int(token.size))pt, Weight: \(token.weight.rawValue)")
              .font(.caption)
              .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))
          }
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct SpacingView: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        Text("Spacing Scale")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

        VStack(alignment: .leading, spacing: 16) {
          spacingExample("XS", value: designSystem.brand.spacing.xs)
          spacingExample("SM", value: designSystem.brand.spacing.sm)
          spacingExample("MD", value: designSystem.brand.spacing.md)
          spacingExample("LG", value: designSystem.brand.spacing.lg)
          spacingExample("XL", value: designSystem.brand.spacing.xl)
          spacingExample("XXL", value: designSystem.brand.spacing.xxl)
          spacingExample("XXXL", value: designSystem.brand.spacing.xxxl)
        }
      }
      .padding()
    }
  }

  @ViewBuilder
  private func spacingExample(_ name: String, value: CGFloat) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text(name)
          .font(.headline)
          .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

        Spacer()

        Text("\(Int(value))pt")
          .font(.caption)
          .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))
      }

      Rectangle()
        .fill(designSystem.color(\.primary, systemScheme: colorScheme))
        .frame(width: value * 4, height: 20)
    }
  }
}

struct ExamplesView: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 32) {
        LoginFormExample()
        ProfileCardExample()
        DashboardExample()
        DocumentBrowserExample()
      }
      .padding()
    }
  }
}

struct LoginFormExample: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme
  @State private var email = ""
  @State private var password = ""

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Login Form Example")
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

      ModernCard {
        VStack(spacing: 20) {
          Text("Welcome Back")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

          VStack(spacing: 16) {
            ModernTextField("Email", text: $email, placeholder: "Enter your email", type: .email)
            ModernTextField("Password", text: $password, placeholder: "Enter your password", type: .password)
          }

          Button("Sign In") {}
            .buttonStyle(ModernButtonStyle(type: .primary, maxWidth: .infinity))

          Button("Forgot Password?") {}
            .buttonStyle(ModernButtonStyle(type: .tertiary))
        }
        .padding(4)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct ProfileCardExample: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Profile Card Example")
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

      ModernCard {
        HStack(spacing: 16) {
          Circle()
            .fill(designSystem.color(\.primary, systemScheme: colorScheme).gradient)
            .frame(width: 60, height: 60)
            .overlay(
              Text("JD")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            )

          VStack(alignment: .leading, spacing: 4) {
            Text("John Doe")
              .font(.headline)
              .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

            Text("iOS Developer")
              .font(.subheadline)
              .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))

            Text("San Francisco, CA")
              .font(.caption)
              .foregroundColor(designSystem.color(\.tertiaryText, systemScheme: colorScheme))
          }

          Spacer()

          Button("Follow") {}
            .buttonStyle(ModernButtonStyle(type: .primary, size: .small))
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct DashboardExample: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Dashboard Example")
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
        StatCard(title: "Total Users", value: "1,234", change: "+12%", isPositive: true)
        StatCard(title: "Revenue", value: "$45,678", change: "+8%", isPositive: true)
        StatCard(title: "Orders", value: "567", change: "-3%", isPositive: false)
        StatCard(title: "Conversion", value: "3.2%", change: "+0.5%", isPositive: true)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct StatCard: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme
  let title: String
  let value: String
  let change: String
  let isPositive: Bool

  var body: some View {
    ModernCard {
      VStack(alignment: .leading, spacing: 8) {
        Text(title)
          .font(.caption)
          .foregroundColor(designSystem.color(\.secondaryText, systemScheme: colorScheme))

        Text(value)
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

        Text(change)
          .font(.caption)
          .foregroundColor(isPositive ? designSystem.color(\.success, systemScheme: colorScheme) : designSystem.color(\.error, systemScheme: colorScheme))
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

struct DocumentBrowserExample: View {
  @EnvironmentObject var designSystem: ModernDesignSystem
  @Environment(\.colorScheme) var colorScheme
  @State private var searchText = ""
  @State private var viewMode: ViewMode = .grid
  @State private var showFavoritesOnly = false

  enum ViewMode {
    case grid, list
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Document Browser Example")
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(designSystem.color(\.primaryText, systemScheme: colorScheme))

      ModernCard {
        VStack(spacing: 16) {
          // Search and controls
          HStack(spacing: 12) {
            ModernTextField("Search", text: $searchText, placeholder: "Search documents...")

            Button(action: { showFavoritesOnly.toggle() }) {
              Image(systemName: showFavoritesOnly ? "star.fill" : "star")
            }
            .buttonStyle(ModernButtonStyle(type: .secondary, size: .medium))

            Button(action: { viewMode = viewMode == .grid ? .list : .grid }) {
              Image(systemName: viewMode == .grid ? "list.bullet" : "square.grid.2x2")
            }
            .buttonStyle(ModernButtonStyle(type: .secondary, size: .medium))
          }

          Divider()

          // Document list
          if filteredDocuments.isEmpty {
            if searchText.isEmpty {
              if showFavoritesOnly {
                EmptyStateView.noFavorites {
                  showFavoritesOnly = false
                }
                .frame(height: 250)
              } else {
                EmptyStateView.noDocuments {
                  print("Open documents")
                }
                .frame(height: 250)
              }
            } else {
              EmptyStateView.noSearchResults(query: searchText)
                .frame(height: 250)
            }
          } else {
            ScrollView {
              Group {
                if viewMode == .grid {
                  LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                    ForEach(filteredDocuments) { doc in
                      DocumentCard(
                        title: doc.title,
                        fileType: doc.fileType,
                        metadata: doc.metadata,
                        isFavorite: doc.isFavorite,
                        style: .compact
                      )
                    }
                  }
                } else {
                  VStack(spacing: 8) {
                    ForEach(filteredDocuments) { doc in
                      DocumentCard(
                        title: doc.title,
                        subtitle: doc.subtitle,
                        fileType: doc.fileType,
                        metadata: doc.metadata,
                        isFavorite: doc.isFavorite,
                        style: .list
                      )
                    }
                  }
                }
              }
              .padding(.vertical, 8)
            }
            .frame(height: 300)
          }
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private var filteredDocuments: [MockDocument] {
    mockDocuments
      .filter { doc in
        if showFavoritesOnly && !doc.isFavorite {
          return false
        }
        if !searchText.isEmpty && !doc.title.localizedCaseInsensitiveContains(searchText) {
          return false
        }
        return true
      }
  }

  private let mockDocuments = [
    MockDocument(
      id: 1,
      title: "Project Proposal.pdf",
      subtitle: "Q4 2025 Planning",
      fileType: .pdf,
      metadata: "2.5 MB • Today",
      isFavorite: true
    ),
    MockDocument(
      id: 2,
      title: "Budget.xlsx",
      subtitle: "Financial spreadsheet",
      fileType: .excel,
      metadata: "1.2 MB • Yesterday",
      isFavorite: false
    ),
    MockDocument(
      id: 3,
      title: "Presentation.pptx",
      subtitle: "Company overview",
      fileType: .powerpoint,
      metadata: "8.4 MB • Dec 2",
      isFavorite: true
    ),
    MockDocument(
      id: 4,
      title: "Notes.pages",
      subtitle: "Meeting minutes",
      fileType: .pages,
      metadata: "0.5 MB • Dec 1",
      isFavorite: false
    ),
    MockDocument(
      id: 5,
      title: "Data.numbers",
      subtitle: "Analytics report",
      fileType: .numbers,
      metadata: "2.1 MB • Nov 30",
      isFavorite: true
    ),
    MockDocument(
      id: 6,
      title: "Slides.keynote",
      subtitle: "Product launch",
      fileType: .keynote,
      metadata: "12.3 MB • Nov 28",
      isFavorite: false
    ),
  ]
}

struct MockDocument: Identifiable {
  let id: Int
  let title: String
  let subtitle: String?
  let fileType: FileTypeIcon.FileType
  let metadata: String
  let isFavorite: Bool
}

// MARK: - Previews

#if DEBUG
  @available(iOS 17.0, macOS 14.0, *)
  #Preview {
    ContentView()
      .environmentObject(ModernDesignSystem.shared)
  }
#endif

//
//  AppIconGenerator.swift
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

import SwiftUI
import ModernDesignSystem
import UniformTypeIdentifiers

#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

enum BackgroundColorOption: String, CaseIterable {
    case designSystem = "Design System"
    case solid = "Solid Color"
    case transparent = "Transparent"
    case white = "White"
    case black = "Black"
}

struct AppIconView: View {
    @EnvironmentObject var designSystem: ModernDesignSystem
    @Environment(\.colorScheme) var colorScheme
    let backgroundColorOption: BackgroundColorOption
    let customBackgroundColor: Color
    
    init(backgroundColorOption: BackgroundColorOption = .designSystem, customBackgroundColor: Color = .blue) {
        self.backgroundColorOption = backgroundColorOption
        self.customBackgroundColor = customBackgroundColor
    }
    
    var body: some View {
        ZStack {
            // Background based on selected option
            backgroundView
            
            // Design system grid pattern
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    Rectangle()
                        .fill(.white.opacity(0.9))
                        .frame(width: 24, height: 24)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(width: 24, height: 24)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(.white.opacity(0.5))
                        .frame(width: 24, height: 24)
                        .cornerRadius(4)
                }
                
                HStack(spacing: 8) {
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(width: 24, height: 24)
                        .cornerRadius(4)
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 24, height: 24)
                        .overlay(
                            Image(systemName: "rectangle.3.group")
                                .foregroundColor(designSystem.color(\.primary, systemScheme: colorScheme))
                                .font(.system(size: 12, weight: .semibold))
                        )
                    
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(width: 24, height: 24)
                        .cornerRadius(4)
                }
                
                HStack(spacing: 8) {
                    Rectangle()
                        .fill(.white.opacity(0.5))
                        .frame(width: 24, height: 24)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(width: 24, height: 24)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(.white.opacity(0.9))
                        .frame(width: 24, height: 24)
                        .cornerRadius(4)
                }
            }
            .scaleEffect(0.85)
        }
        .frame(width: 1024, height: 1024)
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        switch backgroundColorOption {
        case .designSystem:
            LinearGradient(
                colors: [
                    designSystem.color(\.primary, systemScheme: colorScheme),
                    designSystem.color(\.secondary, systemScheme: colorScheme)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .solid:
            customBackgroundColor
        case .transparent:
            Color.clear
        case .white:
            Color.white
        case .black:
            Color.black
        }
    }
}

// MARK: - Icon Generator for different sizes
struct AppIconGeneratorView: View {
    @EnvironmentObject var designSystem: ModernDesignSystem
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedBackgroundColor: BackgroundColorOption = .designSystem
    @State private var customBackgroundColor: Color = .blue
    @State private var isExporting = false
    @State private var showingExportDialog = false
    @State private var exportComplete = false
    @State private var exportError: String?
    
    let sizes: [CGFloat] = [16, 20, 29, 32, 40, 58, 60, 64, 76, 80, 87, 90, 120, 128, 152, 167, 180, 256, 512, 1024]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Controls
            controlsSection
            
            // Icons grid
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                    ForEach(sizes, id: \.self) { size in
                        VStack {
                            AppIconView(
                                backgroundColorOption: selectedBackgroundColor,
                                customBackgroundColor: customBackgroundColor
                            )
                            .frame(width: min(size, 120), height: min(size, 120))
                            .clipShape(RoundedRectangle(cornerRadius: size * 0.18))
                            
                            Text("\(Int(size))pt")
                                .font(.caption)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("App Icon Generator")
        .padding()
        .fileExporter(
            isPresented: $showingExportDialog,
            document: IconSetDocument(),
            contentType: .folder,
            defaultFilename: "AppIconSet"
        ) { result in
            switch result {
            case .success(let url):
                Task {
                    await exportIconsToDirectory(url)
                }
            case .failure(let error):
                exportError = error.localizedDescription
            }
        }
        .alert("Export Complete", isPresented: $exportComplete) {
            Button("OK") { }
        } message: {
            Text("App icons have been exported successfully!")
        }
        .alert("Export Error", isPresented: .constant(exportError != nil)) {
            Button("OK") { exportError = nil }
        } message: {
            Text(exportError ?? "Unknown error occurred")
        }
    }
    
    @ViewBuilder
    private var controlsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Background Options")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Background Style:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Picker("Background", selection: $selectedBackgroundColor) {
                    ForEach(BackgroundColorOption.allCases, id: \.self) { option in
                        Text(getShortName(for: option)).tag(option)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            if selectedBackgroundColor == .solid {
                HStack {
                    Text("Custom Color:")
                    ColorPicker("", selection: $customBackgroundColor)
                        .frame(width: 44, height: 32)
                }
            }
            
            HStack {
                Button("Export All Sizes") {
                    exportIcons()
                }
                .buttonStyle(ModernButtonStyle(type: .primary))
                .disabled(isExporting)
                
                if isExporting {
                    ProgressView()
                        .scaleEffect(0.7)
                }
            }
        }
        .padding()
        .background(designSystem.color(\.secondaryBackground, systemScheme: colorScheme))
        .cornerRadius(12)
    }
    
    private func getShortName(for option: BackgroundColorOption) -> String {
        switch option {
        case .designSystem: return "Design"
        case .solid: return "Solid"
        case .transparent: return "Clear"
        case .white: return "White"
        case .black: return "Black"
        }
    }
    
    private func exportIcons() {
        showingExportDialog = true
    }
    
    @MainActor
    private func exportIconsToDirectory(_ url: URL) async {
        isExporting = true
        
        do {
            // Create directory for icons
            let iconsURL = url.appendingPathExtension("iconset")
            try FileManager.default.createDirectory(at: iconsURL, withIntermediateDirectories: true)
            
            // Generate and save each size
            for size in sizes {
                let actualSize = size * 2 // For @2x resolution
                let filename = getFilenameForSize(size)
                let fileURL = iconsURL.appendingPathComponent(filename)
                
                if let imageData = await renderIconToData(size: actualSize) {
                    try imageData.write(to: fileURL)
                }
            }
            
            // Show success message
            exportComplete = true
            
        } catch {
            exportError = error.localizedDescription
        }
        
        isExporting = false
    }
    
    private func getFilenameForSize(_ size: CGFloat) -> String {
        let intSize = Int(size)
        
        // Apple's standard icon naming conventions for .appiconset
        switch intSize {
        case 16: return "AppIcon-16.png"    // macOS 16x16 1x
        case 20: return "AppIcon-20.png"    // iPad 20x20 1x, iPhone 20x20 1x
        case 29: return "AppIcon-29.png"    // iPhone/iPad 29x29 1x
        case 32: return "AppIcon-32.png"    // macOS 16x16 2x, 32x32 1x
        case 40: return "AppIcon-40.png"    // iPhone/iPad 20x20 2x, iPad 40x40 1x
        case 58: return "AppIcon-58.png"    // iPhone/iPad 29x29 2x
        case 60: return "AppIcon-60.png"    // iPhone 30x30 2x
        case 64: return "AppIcon-64.png"    // macOS 32x32 2x
        case 76: return "AppIcon-76.png"    // iPad 76x76 1x
        case 80: return "AppIcon-80.png"    // iPhone 40x40 2x, iPad 40x40 2x
        case 87: return "AppIcon-87.png"    // iPhone 29x29 3x
        case 90: return "AppIcon-90.png"    // iPhone 30x30 3x
        case 120: return "AppIcon-120.png"  // iPhone 40x40 3x, 60x60 2x
        case 128: return "AppIcon-128.png"  // macOS 128x128 1x
        case 152: return "AppIcon-152.png"  // iPad 76x76 2x
        case 167: return "AppIcon-167.png"  // iPad Pro 83.5x83.5 2x
        case 180: return "AppIcon-180.png"  // iPhone 60x60 3x
        case 256: return "AppIcon-256.png"  // macOS 128x128 2x, 256x256 1x
        case 512: return "AppIcon-512.png"  // macOS 256x256 2x, 512x512 1x
        case 1024: return "AppIcon-1024.png" // iOS Marketing, macOS 512x512 2x
        default: return "AppIcon-\(intSize).png"
        }
    }
    
    private func renderIconToData(size: CGFloat) async -> Data? {
        let iconView = AppIconView(
            backgroundColorOption: selectedBackgroundColor,
            customBackgroundColor: customBackgroundColor
        )
        .environmentObject(designSystem)
        .frame(width: size, height: size)
        
        let renderer = ImageRenderer(content: iconView)
        renderer.scale = 1.0
        
        #if canImport(AppKit)
        guard let nsImage = renderer.nsImage else { return nil }
        guard let tiffData = nsImage.tiffRepresentation else { return nil }
        guard let bitmapRep = NSBitmapImageRep(data: tiffData) else { return nil }
        return bitmapRep.representation(using: .png, properties: [:])
        #elseif canImport(UIKit)
        guard let uiImage = renderer.uiImage else { return nil }
        return uiImage.pngData()
        #else
        return nil
        #endif
    }
}

// MARK: - File Document for Export
struct IconSetDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.folder] }
    
    init() {}
    
    init(configuration: ReadConfiguration) throws {}
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(directoryWithFileWrappers: [:])
    }
}

#if DEBUG
@available(iOS 17.0, macOS 14.0, *)
#Preview("App Icon") {
    AppIconView(backgroundColorOption: .designSystem, customBackgroundColor: .blue)
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 36))
        .environmentObject(ModernDesignSystem.shared)
}

@available(iOS 17.0, macOS 14.0, *)
#Preview("Icon Generator") {
    NavigationView {
        AppIconGeneratorView()
    }
    .environmentObject(ModernDesignSystem.shared)
}
#endif
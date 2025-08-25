# Modern Design System

A comprehensive Swift Package design system for iOS 17+ and macOS 14+ applications, built with SwiftUI and inspired by modern design principles.

## Features

### 🎨 Comprehensive Color System
- **Multiple Color Sets**: 6 beautiful pre-built themes (Modern Blue, Ocean Breeze, Forest Green, Sunset Orange, Deep Purple, Charcoal)
- **Light/Dark Mode Support**: Full adaptive color support with automatic theme switching
- **Semantic Colors**: Logical color tokens for consistent theming across components

### 🔤 Typography System
- **Scalable Typography**: Complete type scale from display to caption sizes
- **Dynamic Type Support**: Accessibility-first font scaling
- **Responsive Sizing**: Adaptive fonts for different device classes

### 🧩 Modern Components
- **Buttons**: Multiple styles (Primary, Secondary, Tertiary, Destructive) with size variants
- **Text Fields**: Email, password, multiline support with validation states
- **Cards**: Flexible card system with elevation and specialized variants
- **Notifications**: Status-aware notifications with actions and dismissal
- **Modern Architecture**: No "Vi" prefixes, clean Swift 6.0 implementation

### 🎯 Developer Experience
- **Swift 6.0**: Built with the latest Swift features and concurrency support
- **Swift Package Manager**: Easy integration with SPM
- **Multiplatform**: iOS 17+, macOS 14+ support
- **Live Preview**: Comprehensive demo app with real-time theme switching

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "path/to/ModernDesignSystem", branch: "main")
]
```

Or in Xcode: File → Add Package Dependencies

## Quick Start

```swift
import SwiftUI
import ModernDesignSystem

@main
struct MyApp: App {
    @StateObject private var designSystem = ModernDesignSystem.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(designSystem)
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, Modern Design!")
                .font(.title)
            
            Button("Primary Action") {
                // Action
            }
            .buttonStyle(ModernButtonStyle(type: .primary))
            
            ModernTextField("Email", text: .constant(""), type: .email)
            
            ModernNotification(
                type: .success,
                title: "Welcome!",
                message: "You're using Modern Design System"
            )
        }
        .padding()
    }
}
```

## Components

### Buttons
```swift
Button("Click me") { }
    .buttonStyle(ModernButtonStyle(
        type: .primary,     // .primary, .secondary, .tertiary, .destructive
        size: .medium       // .small, .medium, .large
    ))
```

### Text Fields
```swift
ModernTextField(
    "Label",
    text: $binding,
    placeholder: "Enter text",
    type: .email,           // .text, .email, .password, .number, .multiline
    isError: false,
    helperText: "Optional helper text"
)
```

### Cards
```swift
ModernCard(elevation: .medium) {
    VStack {
        Text("Card Content")
        Button("Action") { }
    }
}

// Or specialized cards
InfoCard(
    title: "Title",
    subtitle: "Subtitle",
    image: "gear",
    action: { }
)
```

### Notifications
```swift
ModernNotification(
    type: .info,            // .info, .success, .warning, .error
    title: "Title",
    message: "Message",
    action: { },
    actionTitle: "Action",
    onDismiss: { }
)
```

## Theming

### Applying Color Sets
```swift
// Apply a color set
designSystem.applyColorSet(.oceanBreeze)

// Or use environment
.environment(\.modernDesignSystem, designSystem)
```

### Custom Color Sets
```swift
struct MyColorSet: ColorSet {
    let name: ColorSetName = .custom("My Theme")
    let scheme: ColorScheme = .light
    let tintColor: Color = .blue
    let primaryBackgroundColor: Color = .white
    // ... implement other colors
}
```

## Demo App

The included demo app showcases all components and features:

1. **Components Tab**: Interactive examples of all UI components
2. **Colors Tab**: Color palette and theme preview
3. **Typography Tab**: Complete type scale demonstration  
4. **Spacing Tab**: Spacing system visualization
5. **Examples Tab**: Real-world usage examples
6. **Icon Generator Tab**: Create and export app icons with custom backgrounds

Run the demo:
```bash
cd Example
open ModernDesignSystemExample.xcodeproj
```

## Testing

ModernDesignSystem includes comprehensive unit tests covering all core functionality. There are multiple ways to run the tests:

### Option 1: Open Package Directly in Xcode

1. Open the package directly by opening `Package.swift` in Xcode
2. Select the `ModernDesignSystem` scheme from the scheme selector
3. Run tests with `⌘+U` (Test)

This approach gives you full IDE integration with test results, coverage, and debugging capabilities.

### Option 2: Command Line Testing

```bash
# Navigate to the package directory
cd /path/to/ModernDesignSystem

# Run all tests
swift test

# Run tests with verbose output
swift test --verbose
```

The command line approach is perfect for CI/CD pipelines and quick verification during development.

### Test Coverage

The test suite includes:
- **26 comprehensive tests** covering all major components
- **ModernDesignSystem core functionality** (13 tests)
- **ColorToken system** (6 tests) 
- **Theme management** (7 tests)
- **Edge cases and error conditions**
- **Cross-platform compatibility verification**

All tests are designed to run on both iOS and macOS targets.

## Architecture

### Design Tokens
- **Colors**: Semantic color system with light/dark variants
- **Typography**: Scalable font tokens with responsive sizing
- **Spacing**: Consistent spacing scale
- **Elevation**: Configurable shadow system

### Swift 6.0 Features
- `@Observable` for reactive state management
- Structured concurrency support
- Strong typing with `KeyPath`-based color system
- Modern SwiftUI patterns

## Asset Generation Plugin

ModernDesignSystem includes a Swift Package Plugin for generating strongly-typed asset code from `.xcassets` files.

### Usage

Generate asset code from your xcassets:

```bash
swift package plugin generate-moderndesignsystem-assets --allow-writing-to-package-directory
```

This will:
1. Scan for `.xcassets` files in the ModernDesignSystem target
2. Generate an `Assets.swift` file with strongly-typed access to your assets
3. Create `AssetResource` structs for type-safe asset loading

### Generated Code Example

```swift
// Auto-generated in Assets.swift
public extension AssetResource {
    static let myIcon = AssetResource(name: "myIcon", bundle: .module)
    static let backgroundImage = AssetResource(name: "backgroundImage", bundle: .module)
}

// Usage in your code
Image(asset: .myIcon)
UIImage(asset: .backgroundImage)
```

### App Icon Generation

The demo app includes an **Icon Generator** that can:
- Create app icons with custom backgrounds
- Export all standard iOS/macOS icon sizes
- Generate files ready for Xcode import
- Support multiple background styles (gradient, solid, transparent, etc.)

Access via the "Icon Generator" tab in the demo app.

## Requirements

- iOS 17.0+ / macOS 14.0+
- Xcode 15.0+
- Swift 6.0+

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

Modern Design System is available under the MIT license. See LICENSE for details.

## Inspiration

This design system draws inspiration from:
- Material Design 3
- Apple's Human Interface Guidelines
- IceCubesApp's theming system
- Modern design system best practices

---

Built with ❤️ using SwiftUI and Swift 6.0
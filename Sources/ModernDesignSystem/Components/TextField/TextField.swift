//
//  TextField.swift
//  ModernDesignSystem
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

public struct ModernTextField: View {
    @EnvironmentObject var designSystem: ModernDesignSystem
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var isFocused: Bool
    
    private let title: String
    private let text: Binding<String>
    private let placeholder: String
    private let type: TextFieldType
    private let isError: Bool
    private let helperText: String?
    
    public init(
        _ title: String,
        text: Binding<String>,
        placeholder: String = "",
        type: TextFieldType = .text,
        isError: Bool = false,
        helperText: String? = nil
    ) {
        self.title = title
        self.text = text
        self.placeholder = placeholder
        self.type = type
        self.isError = isError
        self.helperText = helperText
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: designSystem.brand.spacing.xs) {
            if !title.isEmpty {
                Text(title)
                    .font(designSystem.brand.typography.labelMedium.font(
                        verticalSizeClass: nil,
                        horizontalSizeClass: nil
                    ))
                    .foregroundColor(textColor)
            }
            
            textFieldView
                .focused($isFocused)
            
            if let helperText = helperText {
                Text(helperText)
                    .font(designSystem.brand.typography.captionMedium.font(
                        verticalSizeClass: nil,
                        horizontalSizeClass: nil
                    ))
                    .foregroundColor(helperTextColor)
            }
        }
    }
    
    @ViewBuilder
    private var textFieldView: some View {
        VStack {
            switch type {
            case .text:
                TextField(placeholder, text: text)
            case .email:
                TextField(placeholder, text: text)
                #if os(iOS)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                #endif
                    .textContentType(.emailAddress)
            case .password:
                SecureField(placeholder, text: text)
                    .textContentType(.password)
            case .number:
                TextField(placeholder, text: text)
                #if os(iOS)
                    .keyboardType(.numberPad)
                #endif
            case .multiline:
                TextField(placeholder, text: text, axis: .vertical)
                    .lineLimit(3...6)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(designSystem.brand.spacing.md)
        .background(backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: borderWidth)
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .animation(.easeInOut(duration: 0.2), value: isError)
    }
    
    private var textColor: Color {
        designSystem.color(\.primaryText, systemScheme: colorScheme)
    }
    
    private var backgroundColor: Color {
        designSystem.color(\.primaryBackground, systemScheme: colorScheme)
    }
    
    private var borderColor: Color {
        if isError {
            return designSystem.color(\.error, systemScheme: colorScheme)
        } else if isFocused {
            return designSystem.color(\.primary, systemScheme: colorScheme)
        } else {
            return designSystem.color(\.primaryBorder, systemScheme: colorScheme)
        }
    }
    
    private var borderWidth: CGFloat {
        isFocused || isError ? 2 : 1
    }
    
    private var helperTextColor: Color {
        if isError {
            return designSystem.color(\.error, systemScheme: colorScheme)
        } else {
            return designSystem.color(\.secondaryText, systemScheme: colorScheme)
        }
    }
}

public enum TextFieldType: Sendable {
    case text
    case email
    case password
    case number
    case multiline
}

// MARK: - Previews
#if DEBUG
@available(iOS 17.0, macOS 14.0, *)
#Preview {
    VStack(spacing: 20) {
        ModernTextField("Email", text: .constant(""), placeholder: "Enter your email", type: .email)
        ModernTextField("Password", text: .constant(""), placeholder: "Enter your password", type: .password)
        ModernTextField("Name", text: .constant("John Doe"), placeholder: "Enter your name", isError: true, helperText: "This field is required")
        ModernTextField("Comments", text: .constant(""), placeholder: "Enter your comments", type: .multiline, helperText: "Optional feedback")
    }
    .padding()
    .environmentObject(ModernDesignSystem.shared)
}
#endif
//
//  MapAssets.swift
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

import Foundation

@main
@available(macOS 13.0.0, *)
enum MapAssets {
    static func main() async throws {
        let arguments = ProcessInfo().arguments
        guard arguments.count > 2 else {
            print("Usage: MapAssets <input> <output>")
            exit(1)
        }

        let (input, output) = (arguments[1], arguments[2])

        let inputURL = URL(fileURLWithPath: input)
        let outputURL = URL(fileURLWithPath: output)

        let code = GenerateAssets.generateCode(findImageSets(in: inputURL))
        do {
            try code.write(to: outputURL, atomically: true, encoding: .utf8)
        } catch {
            print(error)
            exit(2)
        }
    }

    private static func findImageSets(in directory: URL) -> [String] {
        let fileManager = FileManager.default
        let resourceKeys: Set<URLResourceKey> = [.isDirectoryKey, .nameKey]

        // Create a directory enumerator to traverse subdirectories
        guard let enumerator = fileManager.enumerator(at: directory,
                                                      includingPropertiesForKeys: Array(resourceKeys),
                                                      options: [.skipsHiddenFiles],
                                                      errorHandler: nil) else {
            print("Failed to access directory \(directory.path)")
            exit(1)
        }

        var result: [String] = []

        for case let fileURL as URL in enumerator {
            do {
                let resourceValues = try fileURL.resourceValues(forKeys: resourceKeys)
                // Check if the item is a directory and ends with '.imageset'
                if let isDirectory = resourceValues.isDirectory, isDirectory,
                   let name = resourceValues.name, name.hasSuffix(".imageset"),
                   let nameWithoutSuffix = name.components(separatedBy: ".").first {
                    result.append(nameWithoutSuffix)
                }
            } catch {
                print("Error reading directory attributes: \(error.localizedDescription)")
                exit(1)
            }
        }

        return result
    }
}
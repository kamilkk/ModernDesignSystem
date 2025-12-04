//
//  Assets.swift
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

public struct AssetResource: Hashable {
  public let name: String
  public let bundle: Bundle

  public init(name: String, bundle: Bundle) {
    self.name = name
    self.bundle = bundle
  }
}

public struct AllAssets {
  public init() {}
}

public extension AssetResource {}

public extension Image {
  init(asset: AssetResource) {
    self.init(asset.name, bundle: asset.bundle)
  }
}

#if canImport(UIKit)
  import UIKit

  public extension UIImage {
    convenience init?(asset: AssetResource, compatibleWith traitCollection: UITraitCollection? = nil) {
      self.init(named: asset.name, in: asset.bundle, compatibleWith: traitCollection)
    }
  }
#endif

#if canImport(AppKit)
  import AppKit

  public extension NSImage {
    convenience init?(asset: AssetResource) {
      self.init(named: asset.name)
    }
  }
#endif

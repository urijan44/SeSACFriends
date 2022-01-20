// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Color {
  internal static let seSACBlack = ColorAsset(name: "SeSACBlack")
  internal static let seSACError = ColorAsset(name: "SeSACError")
  internal static let seSACFocus = ColorAsset(name: "SeSACFocus")
  internal static let seSACGray1 = ColorAsset(name: "SeSACGray1")
  internal static let seSACGray2 = ColorAsset(name: "SeSACGray2")
  internal static let seSACGray3 = ColorAsset(name: "SeSACGray3")
  internal static let seSACGray4 = ColorAsset(name: "SeSACGray4")
  internal static let seSACGray5 = ColorAsset(name: "SeSACGray5")
  internal static let seSACGray6 = ColorAsset(name: "SeSACGray6")
  internal static let seSACGray7 = ColorAsset(name: "SeSACGray7")
  internal static let seSACGreen = ColorAsset(name: "SeSACGreen")
  internal static let seSACSuccess = ColorAsset(name: "SeSACSuccess")
  internal static let seSACWhite = ColorAsset(name: "SeSACWhite")
  internal static let seSACWhiteGreen = ColorAsset(name: "SeSACWhiteGreen")
  internal static let seSACYellowGreen = ColorAsset(name: "SeSACYellowGreen")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

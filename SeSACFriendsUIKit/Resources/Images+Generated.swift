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
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Images {
  public static let arrow = ImageAsset(name: "arrow")
  public static let cancelMatch = ImageAsset(name: "cancel_match")
  public static let closeBig = ImageAsset(name: "close_big")
  public static let faq = ImageAsset(name: "faq")
  public static let filterControl = ImageAsset(name: "filter_control")
  public static let friendsPlus = ImageAsset(name: "friends_plus")
  public static let logout = ImageAsset(name: "logout")
  public static let man = ImageAsset(name: "man")
  public static let message = ImageAsset(name: "message")
  public static let more = ImageAsset(name: "more")
  public static let notice = ImageAsset(name: "notice")
  public static let permit = ImageAsset(name: "permit")
  public static let place = ImageAsset(name: "place")
  public static let plus = ImageAsset(name: "plus")
  public static let qna = ImageAsset(name: "qna")
  public static let search = ImageAsset(name: "search")
  public static let settingAlarm = ImageAsset(name: "setting_alarm")
  public static let siren = ImageAsset(name: "siren")
  public static let tabFriends = ImageAsset(name: "tabFriends")
  public static let tabHome = ImageAsset(name: "tabHome")
  public static let tabMyinfo = ImageAsset(name: "tabMyinfo")
  public static let tabShop = ImageAsset(name: "tabShop")
  public static let woman = ImageAsset(name: "woman")
  public static let write = ImageAsset(name: "write")
  public static let onboardingText1 = ImageAsset(name: "OnboardingText1")
  public static let onboardingText2 = ImageAsset(name: "OnboardingText2")
  public static let onboardingText3 = ImageAsset(name: "OnboardingText3")
  public static let onboardingImg1 = ImageAsset(name: "onboarding_img1")
  public static let onboardingImg2 = ImageAsset(name: "onboarding_img2")
  public static let onboardingImg3 = ImageAsset(name: "onboarding_img3")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
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

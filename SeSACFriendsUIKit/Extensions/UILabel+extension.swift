//
//  UILabel+extension.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/18.
//

import UIKit

public extension UILabel {

  enum TypoStyle {
    case display1
    case title1
    case title2
    case title3
    case title4
    case title5m
    case title5r
    case title6r
    case body1
    case body2
    case body3
    case body4
    case caption

    var lineHeight: CGFloat {
      switch self {
        case .display1:
          return 32
        case .title1:
          return 25.6
        case .title2:
          return 25.6
        case .title3:
          return 22.4
        case .title4:
          return 22.4
        case .title5m:
          return 18
        case .title5r:
          return 18
        case .title6r:
          return 18
        case .body1:
          return 29.6
        case .body2:
          return 29.6
        case .body3:
          return 23.8
        case .body4:
          return 22.4
        case .caption:
          return 16
      }
    }

  }

  convenience init(typoStyle: TypoStyle) {
    self.init()
    let style = NSMutableParagraphStyle()
    let lineHeight = typoStyle.lineHeight
    style.minimumLineHeight = lineHeight
    style.maximumLineHeight = lineHeight

    let font: UIFont
    switch typoStyle {
      case .display1:
        font = .display1
      case .title1:
        font = .title1m
      case .title2:
        font = .title2r
      case .title3:
        font = .title3m
      case .title4:
        font = .title4r
      case .title5m:
        font = .title5m
      case .title5r:
        font = .title5r
      case .title6r:
        font = .title6r
      case .body1:
        font = .body1m
      case .body2:
        font = .body2r
      case .body3:
        font = .body3r
      case .body4:
        font = .body4r
      case .caption:
        font = .captionR
    }

    attributedText = NSAttributedString(
      string: "empty",
      attributes: [
        .font: font,
        .paragraphStyle: style,
        .baselineOffset: (lineHeight - font.lineHeight) / 2 / 2
      ])
  }
}

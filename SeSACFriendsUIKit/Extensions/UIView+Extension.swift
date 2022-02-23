//
//  UIView+Extension.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/21.
//

import UIKit
public extension UIView {
  func allSubviews() -> [UIView] {
    var subs = self.subviews
    for subview in subviews {
      let rec = subview.allSubviews()
      subs.append(contentsOf: rec)
    }
    return subs
  }
}

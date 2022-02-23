//
//  UIApplication+Extension.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/21.
//

import UIKit

public extension UIApplication {
  var key: UIWindow? {
    self.connectedScenes
      .map {$0 as? UIWindowScene}
      .compactMap{ $0 }
      .first?
      .windows
      .filter {$0.isKeyWindow}
      .first
  }
}

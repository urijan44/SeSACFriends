//
//  View+Extension.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/21.
//

import SwiftUI

public extension View {
  func tabBar() -> UITabBar? {
    var tabbar: UITabBar?
    UIApplication.shared.key?.allSubviews().forEach({ subView in
      if let view = subView as? UITabBar {
        tabbar = view
      }
    })
    return tabbar
  }
}

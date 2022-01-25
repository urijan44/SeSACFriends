//
//  View+Extension.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/25.
//

import UIKit
import Toast

extension UIView {
  func showToast(_ message: String) {
    makeToast(message, duration: 2.0)
  }
}

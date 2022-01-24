//
//  Font.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import UIKit
import SwiftUI

extension Font {
  init(uiFont: UIFont) {
    self = Font(uiFont as CTFont)
  }
}

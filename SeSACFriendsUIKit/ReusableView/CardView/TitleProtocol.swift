//
//  TitleProtocol.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import Foundation

public protocol SeSACTitle {
  var title: String { get set }
  var check: Bool { get set }

  init(title: String, check: Bool)
}

public extension SeSACTitle {
  init(title: String) {
    self.init(title: title, check: false)
  }
}

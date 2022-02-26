//
//  SeSACButton+Extension.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/26.
//

import Foundation
import SeSACFriendsUIKit
import RxSwift
import RxCocoa

extension Reactive where Base: SeSACButton {
  var tap: ControlEvent<Void> {
    controlEvent(.touchUpInside)
  }
}

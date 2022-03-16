//
//  SeSACFriendsUIKit+Rx+Extension.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/03/17.
//

import Foundation
import RxSwift
import SeSACFriendsUIKit
import RxCocoa

extension Reactive where Base: LocationButton {
  var tap: ControlEvent<Void> {
    controlEvent(.touchUpInside)
  }
}

extension Reactive where Base: SeSACButton {
  var tap: ControlEvent<Void> {
    controlEvent(.touchUpInside)
  }
}

extension Reactive where Base: SeSACGenderIndicator {
  public var tap: ControlEvent<Void> {
    return base.rx.controlEvent(.touchUpInside)
  }
}

extension Reactive where Base: SeSACBirthField {
  var tap: ControlEvent<Void> {
    controlEvent(.touchUpInside)
  }
}

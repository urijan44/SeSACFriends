//
//  SeSACBirthField+Extension.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/25.
//

import UIKit
import SeSACFriendsUIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: SeSACBirthField {
  var tap: ControlEvent<Void> {
    controlEvent(.touchUpInside)
  }
}

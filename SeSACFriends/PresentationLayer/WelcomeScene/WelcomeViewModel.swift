//
//  WelcomeViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import UIKit
import SeSACFriendsUIKit
import RxSwift
import RxCocoa

final class WelcomeViewModel {
  let bag = DisposeBag()

  struct Input {
    let start: ControlEvent<Void>
  }

  struct Output {
    let start: Driver<Void>
  }

  func transform(input: Input) -> Output {
    let start = input.start.asDriver()
    return Output(start: start)
  }

}

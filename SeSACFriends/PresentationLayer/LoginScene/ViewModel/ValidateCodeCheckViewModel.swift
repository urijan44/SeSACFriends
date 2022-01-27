//
//  ValidateNumberCheckViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/25.
//

import Foundation
import RxSwift
import RxRelay

final class ValidateCodeCheckViewModel: CommonViewModel {

  let bag = DisposeBag()

  struct Input {
    //view appear -> time running!
    let viewAppear: Observable<Void>
    let codeInput: Observable<String>
    let retryButton: Observable<Void>
    let tryAuthentication: Observable<Void>

  }

  struct Output {
    let tryButtonEnable: BehaviorRelay<Bool> = .init(value: false)
    let retryButtonEnable: BehaviorRelay<Bool> = .init(value: false)
    let timer: BehaviorRelay<String> = .init(value: "01:00")
  }

  func transform(_ input: Input) -> Output {

    input.codeInput.subscribe(onNext: { [weak self] code in
      //usecase input code
    }).disposed(by: bag)

    input.viewAppear.subscribe(onNext: { _ in

    }).disposed(by: bag)

    return Output()
  }
}

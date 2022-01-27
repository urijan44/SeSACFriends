//
//  ValidateCodeUseCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/27.
//

import Foundation
import RxSwift
import RxRelay

final class ValidateCodeUseCase: UseCase {
  private let initializeTime = 5
  private var timer = Timer()
  var timeOut: BehaviorRelay<String> = .init(value: "01:00")
  var tryButtonDisabled: BehaviorRelay<Bool> = .init(value: true)
  var retryButtonDisabled: BehaviorRelay<Bool> = .init(value: true)
  private lazy var time: Int = initializeTime

  func timeOutCalculate() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sendTimeOut), userInfo: nil, repeats: true)
  }

  func codeInputCheck(_ text: String) {
    tryButtonDisabled.accept(!(text.count == 6))
  }

  @objc private func sendTimeOut() {
    if time <= 1 {
      timer.invalidate()
      retryButtonDisabled.accept(false)
    }
    time -= 1

    timeOut.accept(timeConvert())
  }

  private func timeConvert() -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .full
    let string = formatter.string(from: TimeInterval(time)) ?? ""
    return string
  }

  func retryReqeust() {
    time = initializeTime
    timeOut.accept(timeConvert())
    timeOutCalculate()
    retryButtonDisabled.accept(true)
  }
}

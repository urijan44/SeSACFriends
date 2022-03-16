//
//  SeSACTextField+Extension.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/26.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import SeSACFriendsUIKit

final class SeSACTextFieldRx: SeSACTextField {
  lazy var rxText: ControlProperty<String?> = {
    textField.rx.text
  }()
}

final class ValidateNumberTextFieldRx: ValidateNumberTextField {
  lazy var rxText: ControlProperty<String?> = {
    textField.rx.text
  }()
}

final class SeSACUnitFieldRx: SeSACUnitField {
  lazy var rxText: ControlProperty<String?> = {
    self.textField.rx.text
  }()
}

final class SeSACGenderPickerRx: SeSACGenderPicker {
  override var selectedGender: SeSACGenderPicker.Gender {
    didSet {
      gender.accept(selectedGender.rawValue)
    }
  }

  public lazy var gender: BehaviorRelay<Int> = .init(value: -1)
}


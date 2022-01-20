//
//  PhoneAuthMainView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/18.
//

import UIKit
import SnapKit
import Then
import SeSACFriendsUIKit

class PhoneAuthMainView: UIView {

  let greetingLabel = UILabel(typoStyle: .display1).then {
    $0.numberOfLines = 2
    $0.textAlignment = .center
    $0.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
  }

  lazy var button = SeSACButton(style: .fill).then {
    $0.title = "인증 문자 받기"
  }

  let textField = SeSACTextField().then {
    $0.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
    $0.subText = "에러 입력하기"
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .seSACWhite
    addSubview(greetingLabel)
    addSubview(button)
//    addSubview(textField)
    greetingLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(169)
    }

    button.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(44)
    }

//    textField.snp.makeConstraints { make in
//      make.leading.trailing.equalTo(button)
//      make.top.equalTo(greetingLabel.snp.bottom).offset(64)
//      make.height.equalTo(48)
//      make.centerX.equalToSuperview()
//    }

//    textField.fieldState = .focus


  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

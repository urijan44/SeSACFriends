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

  let button = SeSACButton(style: .fill).then {
    $0.title = "인증 문자 받기"
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = Color.seSACWhite.color
    addSubview(greetingLabel)
    addSubview(button)
    greetingLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(169)
    }

    button.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(44)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

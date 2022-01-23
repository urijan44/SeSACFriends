//
//  WelcomeContainer.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/23.
//

import SeSACFriendsUIKit

final class WelcomeUIFactory {
  func makeStartButton() -> SeSACButton {
    let button = SeSACButton(style: .fill)
    button.title = "시작하기"
    return button
  }
}

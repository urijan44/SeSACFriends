//
//  SeSACButtonRP.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/26.
//

import SwiftUI
struct SeSACButtonRP: UIViewRepresentable {
  let title: String
  let style: SeSACButton.Style

  func makeUIView(context: UIViewRepresentableContext<SeSACButtonRP>) -> SeSACButton {
    let button = SeSACButton(style: style)
    button.title = self.title
    return button
  }

  func updateUIView(_ uiView: SeSACButton, context: Context) {
  }

  init(title: String = "", style: SeSACButton.Style) {
    self.title = title
    self.style = style
  }
}

//
//  TitleButton.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

struct TitleButton: View {
  @Binding var check: Bool
  @Binding var text: String
  var body: some View {
    Button {
      check.toggle()
    } label: {
      SeSACButtonSU(check: $check)
        .overlay(
          Text(text)
            .font(Font(uiFont: .title4r))
            .foregroundColor(check ? Color(.seSACWhite) : Color(.seSACBlack))
        )
    }
  }

  init(check: Binding<Bool>, text: Binding<String>) {
    self._check = check
    self._text = text
  }
}

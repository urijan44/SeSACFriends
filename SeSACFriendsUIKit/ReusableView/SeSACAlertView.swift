//
//  SeSACAlertView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/24.
//

import SwiftUI

struct SeSACAlertView: View {

  let title: String
  let message: String
  let cancelText: String
  let confirmText: String
  var cancelAction: (() -> Void)?
  var confirmAction: (() -> Void)?
  var body: some View {

    ZStack {
      Color(.seSACBlack).opacity(0.5)
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(Color(.seSACWhite))
        .frame(height: 156, alignment: .center)
      .padding(.horizontal, 16)
      .overlay(
        VStack(spacing: 0) {
          Text(title)
            .font(Font(uiFont: .body1m))
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
          Text(message)
            .font(Font(uiFont: .title4r))
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
          HStack(spacing: 8) {
            SeSACButtonRP(title: "취소", style: .cancel)
              .frame(height: 48)
              .padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 0))
              .onTapGesture {
                self.cancelAction?()
              }
            SeSACButtonRP(title: "확인", style: .fill)
              .frame(height: 48)
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 32))
              .onTapGesture {
                self.confirmAction?()
              }
          }
        }
      )
    }
  }
}

struct SeSACAlertView_Previews: PreviewProvider {
  static var previews: some View {
    SeSACAlertView(title: "약속을 취소하겠습니까?", message: "약속을 취소하시면 패널티가 부과됩니다.", cancelText: "취소", confirmText: "확인", cancelAction: nil, confirmAction: nil)
  }
}

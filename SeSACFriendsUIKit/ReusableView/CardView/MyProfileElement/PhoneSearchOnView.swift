//
//  PhoneSearchOnView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

public struct PhoneSearchOnView: View {
  @Binding var phoneSearchable: Bool

  public var body: some View {
    HStack {
      Text("내 번호 검색 허용")
        .font(Font(uiFont: .title4r))
        .foregroundColor(Color(.seSACBlack))
      Spacer()
      SeSACToggleSwitch(isOn: $phoneSearchable)
        .frame(width: 52, height: 25)
    }
    .frame(height: 48)
  }

  public init(phoneSearchable: Binding<Bool>) {
    self._phoneSearchable = phoneSearchable
  }
}

struct PhoneSearchOnView_Previews: PreviewProvider {
  static var previews: some View {
    PhoneSearchOnView(phoneSearchable: .constant(true))
  }
}

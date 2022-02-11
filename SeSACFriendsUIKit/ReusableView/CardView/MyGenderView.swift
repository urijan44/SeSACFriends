//
//  MyGenderView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

public struct MyGenderView: View {
  @Binding public var gender: Int
  public var body: some View {
    HStack {
      Text("내 성별")
        .font(Font(uiFont: .title4r))
      Spacer()
      GenderContol(gender: $gender)
    }
  }

  public init(gender: Binding<Int>) {
    self._gender = gender
  }
}

fileprivate struct GenderContol: View {

  @Binding var gender: Int

  @State var mail: Bool
  @State var femail: Bool
  var body: some View {
    HStack(spacing: 8) {
      GenderButton(text: "남자", isSelected: $mail)
        .frame(width: 56, height: 48)
        .onTapGesture {
          gender = 1
          femail = false
          mail = true
        }
      GenderButton(text: "여자", isSelected: $femail)
        .frame(width: 56, height: 48)
        .onTapGesture {
          gender = 0
          femail = true
          mail = false
        }
    }
  }
  init(gender: Binding<Int>) {
    self._gender = gender
    mail = gender.wrappedValue == 1
    femail = gender.wrappedValue == 0
  }
}

fileprivate struct GenderButton: View {

  var text: String
  @Binding var isSelected: Bool

  var body: some View {
    SeSACButtonSU(check: $isSelected)
      .overlay(
        Text(text)
          .font(Font(uiFont: .body3r))
          .foregroundColor(isSelected ? Color(.seSACWhite) : Color(.seSACBlack))
      )
  }
}

fileprivate struct MyGenderView_Previews: PreviewProvider {
  static var previews: some View {
    MyGenderView(gender: .constant(0))
  }
}

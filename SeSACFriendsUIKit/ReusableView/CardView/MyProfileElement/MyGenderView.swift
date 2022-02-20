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
  @Binding var gender: Int {
    didSet {
      if gender == 1 {
        isFemail = false
        isMail = true
      } else if gender == 0 {
        isFemail = true
        isMail = false
      }
    }
  }
  @State var isMail: Bool = false
  @State var isFemail: Bool = false

  var body: some View {
    HStack(spacing: 8) {
      GenderButton(text: "남자", isSelected: $isMail)
        .frame(width: 56, height: 48)
        .onTapGesture {
          gender = 1
        }
      GenderButton(text: "여자", isSelected: $isFemail)
        .frame(width: 56, height: 48)
        .onTapGesture {
          gender = 0
        }
    }
    .onChange(of: gender) { newValue in
      isMail = newValue == 1
      isFemail = newValue == 0
    }
  }

  init(gender: Binding<Int>) {
    self._gender = gender
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

  init(text: String, isSelected: Binding<Bool>) {
    self.text = text
    self._isSelected = isSelected
  }
}

fileprivate struct MyGenderView_Previews: PreviewProvider {
  static var previews: some View {
    MyGenderView(gender: .constant(0))
  }
}

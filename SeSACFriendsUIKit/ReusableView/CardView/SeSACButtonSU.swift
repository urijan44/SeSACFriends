//
//  SeSACButtonSU.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

struct SeSACButtonSU: View {

  @Binding var check: Bool

  var body: some View {
    if check {
      RoundedRectangle(cornerRadius: 8)
        .foregroundColor(Color(.seSACGreen))
    } else {
      RoundedRectangle(cornerRadius: 8)
        .strokeBorder(Color(.seSACGray4), lineWidth: 1)
    }
  }
}

struct SeSACButtonSU_Previews: PreviewProvider {
    static var previews: some View {
      SeSACButtonSU(check: .constant(true))
    }
}

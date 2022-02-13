//
//  AgeFilter.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/12.
//

import SwiftUI

struct AgeFilter: View {
  @Binding var minAge: Int
  @Binding var maxAge: Int
  var body: some View {
    HStack {
      Text("상대방 연령대")
        .font(Font(uiFont: .title4r))
        .foregroundColor(Color(.seSACBlack))
      Spacer()
      Text("\(minAge) - \(maxAge)")
        .font(Font(uiFont: .title3m))
        .foregroundColor(Color(.seSACGreen))
    }
  }
}

struct AgeFilter_Previews: PreviewProvider {
  static var previews: some View {
    AgeFilter(minAge: .constant(18), maxAge: .constant(35))
  }
}

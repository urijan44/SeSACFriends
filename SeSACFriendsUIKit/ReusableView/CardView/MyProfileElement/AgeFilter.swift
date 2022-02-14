//
//  AgeFilter.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/12.
//

import SwiftUI

public struct AgeFilter: View {
  @Binding var minAge: Int
  @Binding var maxAge: Int
  public var body: some View {
    GeometryReader { proxy in
      VStack {
        HStack {
          Text("상대방 연령대")
            .font(Font(uiFont: .title4r))
            .foregroundColor(Color(.seSACBlack))
          Spacer()
          Text("\(minAge) - \(maxAge)")
            .font(Font(uiFont: .title3m))
            .foregroundColor(Color(.seSACGreen))
        }
        DoubleSlider(leftValue: $minAge, rightValue: $maxAge, viewSize: proxy.size.width)
      }
    }
  }

  public init(leftValue: Binding<Int>, rightValue: Binding<Int>) {
    self._minAge = leftValue
    self._maxAge = rightValue
  }
}

//struct AgeFilter_Previews: PreviewProvider {
//  static var previews: some View {
//    AgeFilter(minAge: .constant(18), maxAge: .constant(35))
//  }
//}

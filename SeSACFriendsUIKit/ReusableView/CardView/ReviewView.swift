//
//  ReviewView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

struct ReviewView: View {
  @Binding var review: String
  var body: some View {
    VStack {
      HStack {
        Text("새싹 리뷰")
          .font(Font(uiFont: .title6r))
          .foregroundColor(Color(.seSACBlack))
          .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        if !review.isEmpty {
          Image(uiImage: AssetImage.moreArrow.image)
        }
      }
      ReviewText()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(16)

  }

  @ViewBuilder
  func ReviewText() -> some View {
    if review.isEmpty {
      Text("첫 리뷰를 기다리는 중이에요!")
        .foregroundColor(Color(.seSACGray6))
    } else {
      Text(review)
    }
  }
}

struct ReviewView_Previews: PreviewProvider {
  static var previews: some View {
    ReviewView(review: .constant(""))
  }
}

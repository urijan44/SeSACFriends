//
//  ProfileView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/10.
//

import SwiftUI
import SeSACFriendsUIKit

struct ProfileView: View {
  @State var title: [ConvertedTitle] =
  [
    .init(title: "좋은 매너"),
    .init(title: "정확한 시간 약속"),
    .init(title: "빠른 응답"),
    .init(title: "친절한 성격"),
    .init(title: "능숙한 취미 실력"),
    .init(title: "유익한 시간"),
  ]

  @State var gender: Int = 0

  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ProfileCardView()
        .padding(.horizontal, 16)
      GenderView()
        .padding(.horizontal, 16)
    }
  }

  @ViewBuilder
  func ProfileCardView() -> some View {
    CardView(
      backgroundImage: Image(uiImage: AssetImage.sesacBackground1.image),
      faceImage: Image(uiImage: AssetImage.sesacFace1.image),
      name: "김새싹",
      title: $title,
      hobbies: [],
      reviews: [],
    isSearchView: false)
  }

  @ViewBuilder
  func GenderView() -> some View {
    MyGenderView(gender: $gender)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

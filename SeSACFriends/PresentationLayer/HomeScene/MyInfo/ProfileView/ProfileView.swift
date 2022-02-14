//
//  ProfileView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/10.
//

import SwiftUI
import SeSACFriendsUIKit

struct ProfileView: View {
  @State var gender: Int = 0
  @State var hobby: String = "뜨개질"
  @State var phoneSearchable: Bool = true
  @ObservedObject var viewModel = ProfileViewModel()

  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ProfileCardView()
      GenderView()
      FavoriteHobby(hobby: $hobby)
      PhoneSearchOnView(phoneSearchable: $phoneSearchable)
      AgeFilter(leftValue: $viewModel.lowerAge, rightValue: $viewModel.higherAge)
    }
    .padding(.horizontal, 16)
  }

  @ViewBuilder
  func ProfileCardView() -> some View {
    CardView(
      backgroundImage: Image(uiImage: AssetImage.sesacBackground1.image),
      faceImage: Image(uiImage: AssetImage.sesacFace1.image),
      name: "김새싹",
      title: $viewModel.title,
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

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
        .frame(height: 48)
      FavoriteHobby(hobby: $hobby)
        .frame(height: 48)
      PhoneSearchOnView(phoneSearchable: $phoneSearchable)
        .frame(height: 48)
      AgeFilter(leftValue: $viewModel.lowerAge, rightValue: $viewModel.higherAge)
        .frame(height: 80)
        .padding(.top, 16)
      Button {
        viewModel.requestWithdraw()
      } label: {
        Text("탈퇴하기")
          .font(.callout)
          .foregroundColor(Color(.seSACBlack))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .frame(height: 48)
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

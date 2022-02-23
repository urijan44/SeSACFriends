//
//  ProfileView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/10.
//

import SwiftUI
import SeSACFriendsUIKit
import RxSwift
import RxCocoa

struct ProfileView: View {
  @Environment(\.presentationMode) var presentation
  @StateObject var viewModel: ProfileViewModel
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      CardView(
        backgroundImage: Image(uiImage: AssetImage.sesacBackground1.image),
        faceImage: Image(uiImage: AssetImage.sesacFace1.image),
        name: $viewModel.nickname,
        title: $viewModel.reputation,
        hobbies: $viewModel.hobbies,
        reviews: $viewModel.userProfile.comment,
        isSearchView: false)
        .padding(.bottom, 16)
      MyGenderView(gender: $viewModel.userProfile.gender)
        .frame(height: 48)
      FavoriteHobby(hobby: $viewModel.userProfile.hobby)
        .frame(height: 48)
      PhoneSearchOnView(phoneSearchable: $viewModel.userProfile.searchable)
        .frame(height: 48)
      AgeFilter(leftValue: $viewModel.userProfile.ageMin, rightValue: $viewModel.userProfile.ageMax)
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
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarLeading) {
          Button {
            presentation.wrappedValue.dismiss()
            if let tabBar = tabBar(), tabBar.center.y > UIScreen.main.bounds.height - 44 {
              UIView.animate(withDuration: 0.3) {
                tabBar.center.y -= 88
              }
            }
          } label : {
            Image(uiImage: AssetImage.arrow.image)
          }
        }
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button {
            viewModel.update()
          } label: {
            if viewModel.isProgressing {
              ProgressView()
                .progressViewStyle(.circular)
            } else {
              Text("저장")
                .font(Font(uiFont: .title3m))
                .foregroundColor(Color(.seSACBlack))
            }
          }
          .disabled(viewModel.isProgressing)
          .frame(width: 26, height: 22)
        }
      }
    }
    .padding(.horizontal, 16)
    .onReceive(viewModel.$dismissSignal) { signal in
      if signal {
        presentation.wrappedValue.dismiss()
      }
    }
    .onAppear {
      viewModel.loadUserProfile()
      if let tabBar = tabBar() {
        UIView.animate(withDuration: 0.3) {
          tabBar.center.y += 88
        }
      }
    }
    .onDisappear {
      print("ProfileView Disappear")
    }
    .alert(isPresented: $viewModel.showToast.state) {
      Alert(title: Text("알람"), message: Text(viewModel.showToast.message))
    }
    .navigationTitle("정보 관리")
    .navigationBarBackButtonHidden(true)
  }
}

//struct ProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//    ProfileView(viewModel: ProfileViewModel(useCase: , coordinator: <#T##Coordinator#>))
//  }
//}

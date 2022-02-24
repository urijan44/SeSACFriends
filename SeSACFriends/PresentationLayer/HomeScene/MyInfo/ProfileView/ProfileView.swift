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
    ZStack {
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
          withAnimation(.easeIn(duration: 0.2)) {
            viewModel.showWithdrawAlert.toggle()
          }
        } label: {
          Text("탈퇴하기")
            .font(.callout)
            .foregroundColor(Color(.seSACBlack))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .disabled(viewModel.isProgressing)
        .frame(height: 48)
        .toolbar {
          ToolbarItemGroup(placement: .navigationBarLeading) {
            Button {
              presentation.wrappedValue.dismiss()
              tabBarReset()
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
          tabBarReset()
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
      Color.clear
        .allowsHitTesting(false)
        .sesacAlert(isPresenting: $viewModel.showWithdrawAlert) {
          SeSACAlert(title: "정말 탈퇴하시겠습니까?", message: "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ") {
            viewModel.showWithdrawAlert.toggle()
          } confirmAction: {
            presentation.wrappedValue.dismiss()
            tabBarReset()
          }
        }
    }
  }

  func tabBarReset() {
    if let tabBar = tabBar(), tabBar.center.y > UIScreen.main.bounds.height - 44 {
      UIView.animate(withDuration: 0.3) {
        tabBar.center.y -= 88
      }
    }
  }
}

//struct ProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//    ProfileView(viewModel: .init(useCase: DefaultProfileUseCase(serverRepository: DefaultServerRepository(remoteAPIService: SeSACRemoteAPI())), coordinator: nil))
//  }
//}

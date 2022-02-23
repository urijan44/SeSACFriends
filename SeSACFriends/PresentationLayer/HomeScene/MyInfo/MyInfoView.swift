//
//  MyInfoView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/02.
//

import UIKit
import SwiftUI
import SeSACFriendsUIKit

struct MyInfoView: View {

  var viewModel = MyInfoViewModel()
  var body: some View {
    NavigationView {
      VStack {
        NavigationLink {
          ProfileView(
            viewModel: ProfileView.ProfileViewModel(
              useCase: DefaultProfileUseCase(
                serverRepository: DefaultServerRepository(
                  remoteAPIService: SeSACRemoteAPI())),
              coordinator: nil))
        } label: {
          HStack(alignment: .center, spacing: 13) {
            Image(uiImage: AssetImage.profileImg.image)
            .resizable()
            .frame(width: 50, height: 50, alignment: .center)
            Text("김새싹")
              .foregroundColor(Color(.seSACBlack))
              .font(.init(uiFont: .title1m))
            Spacer()
            Image(uiImage: AssetImage.moreArrow.image)
              .resizable()
              .frame(width: 24, height: 24)
          }
          .frame(height: 96)
          .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 22.5))
        }
        List(viewModel.infolist) { info in
          MyInfoListView(image: info.image, title: info.title)
        }
        .onAppear(perform: {
          UITableView.appearance().isScrollEnabled = false
        })
        .listStyle(.plain)
      }
      .navigationTitle("내정보")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct MyInfoView_Previews: PreviewProvider {
  static var previews: some View {
    MyInfoView()
  }
}

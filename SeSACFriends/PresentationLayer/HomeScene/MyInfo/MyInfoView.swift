//
//  MyInfoView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/02.
//

import SwiftUI
import SeSACFriendsUIKit

struct MyInfoView: View {

  var viewModel = MyInfoViewModel()

  var body: some View {
    VStack {
      NavigationLink {
        TempTap()
      } label: {
        HStack(spacing: 13) {
          ZStack {
            Circle()
              .foregroundColor(.clear)
              .border(.black, width: 1)
            Image(uiImage: AssetImage.sesacFace1.image)
              .resizable()
          }
          .frame(width: 50, height: 50, alignment: .center)
          Text("김새싹")
          Spacer()
        }
      }
      List(viewModel.infolist) { info in
        MyInfoListView(image: info.image, title: info.title)
      }
      .listStyle(.plain)
    }
  }
}

struct MyInfoView_Previews: PreviewProvider {
  static var previews: some View {
    MyInfoView()
  }
}

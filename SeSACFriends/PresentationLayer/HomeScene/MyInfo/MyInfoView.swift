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

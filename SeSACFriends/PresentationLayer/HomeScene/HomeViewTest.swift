//
//  HomeViewTest.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/01.
//

import SwiftUI

struct HomeViewTest: View {
  let user = UserSession.shared.userProfile
  var body: some View {
    VStack {
      Text("Welcome SeSAC Friends!!")
      Text(user.phoneNumber ?? "")
      Text(user.nickname ?? "")
      Text(user.fcmToken ?? "")
    }
  }
}

struct HomeViewTest_Previews: PreviewProvider {
  static var previews: some View {
    HomeViewTest()
  }
}

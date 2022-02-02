//
//  HomeViewTest.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/01.
//

import SwiftUI

struct HomeViewTest: View {
  @Environment(\.presentationMode) var presentationMode
  let user = UserSession.shared.userProfile
  var body: some View {
    VStack {
      Text("Welcome SeSAC Friends!!")
      Text(user.phoneNumber ?? "")
      Text(user.nickname ?? "")
      Text(user.fcmToken ?? "")
      Button {
        let api = SeSACRemoteAPI()
        api.withdraw(
          idToken: UserSession.shared.loadIdToken() ?? "") { result in
            switch result {
              case .success:
                UserSession.shared.removeUserSession()
                UserSession.shared.sessionState = .logout
                fatalError("app down")
              case .failure(let error):
                print(error)
            }
          }
      } label: {
        Text("탈퇴하기")
      }

    }
  }
}

struct HomeViewTest_Previews: PreviewProvider {
  static var previews: some View {
    HomeViewTest()
  }
}

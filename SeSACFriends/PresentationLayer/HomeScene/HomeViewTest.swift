//
//  HomeViewTest.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/01.
//

import SwiftUI
import SeSACFriendsUIKit

struct HomeViewTest: View {
  @Environment(\.presentationMode) var presentationMode
  let user = UserSession.shared.userProfile
  var body: some View {
    ZStack {
      TabView {
        VStack {
          Text("Welcome SeSAC Friends!!")
          Text(user.phoneNumber)
          Text(user.nickname)
          Text(user.fcmToken)
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
        .tabItem {
          Image(uiImage: AssetImage.tabHome.image)
          Text("홈")
        }
        Text("새싹샵")
          .tabItem {
            Image(uiImage: AssetImage.tabShop.image)
            Text("새싹샵")
          }
        Text("새싹친구")
          .tabItem {
            Image(uiImage: AssetImage.tabFriends.image)
            Text("새싹친구")
          }
        MyInfoViewControllerRP()
          .tabItem {
            Image(uiImage: AssetImage.tabMyinfo.image)
            Text("내정보")
          }
      }
      .tabViewTintColor(tintColor: .seSACGreen)
    }
  }
}

extension View {
  func tabViewTintColor(tintColor: UIColor? = nil) -> some View {
    onAppear {
      let item = UITabBarItemAppearance()
      item.selected.iconColor = tintColor
      item.selected.titleTextAttributes = [.foregroundColor: tintColor ?? UIColor.seSACBlack]

      let appearence = UITabBarAppearance()
      appearence.stackedLayoutAppearance = item
      appearence.inlineLayoutAppearance = item
      appearence.compactInlineLayoutAppearance = item
      UITabBar.appearance().standardAppearance = appearence
    }
  }
}

struct HomeViewTest_Previews: PreviewProvider {
  static var previews: some View {
    HomeViewTest()
  }
}

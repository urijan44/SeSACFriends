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
  weak var coordinator: Coordinator?
  let user = UserSession.shared.userProfile
  var body: some View {
    ZStack {
      TabView {
        HomeMapViewRepresentable()
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
        MyInfoView(
          viewModel: MyInfoViewModel(),
          coordinator: coordinator
        )
          .tabItem {
            Image(uiImage: AssetImage.tabMyinfo.image)
            Text("내정보")
          }
      }
      .tabViewTintColor(tintColor: .seSACGreen)
    }
  }

  init(coordinator: Coordinator? = nil) {
    self.coordinator = coordinator
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

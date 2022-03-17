//
//  HomeViewTest.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/01.
//

import SwiftUI
import SeSACFriendsUIKit
import RxSwift
import Combine

struct HomeTapView: View {

  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var router: Router
  var coordinator: Coordinator?
  var body: some View {
    ZStack {
      TabView(selection: $router.tab) {
        HomeMapViewRepresentable(router: router)
          .ignoresSafeArea()
        .tabItem {
          Image(uiImage: AssetImage.tabHome.image)
          Text("홈")
        }
        .tag(Router.Tab.home)
        Text("새싹샵")
          .tabItem {
            Image(uiImage: AssetImage.tabShop.image)
            Text("새싹샵")
          }
          .tag(Router.Tab.shop)
        FriendListViewSU()
          .tabItem {
            Image(uiImage: AssetImage.tabFriends.image)
            Text("새싹친구")
          }
          .tag(Router.Tab.freinds)
        MyInfoView(
          viewModel: MyInfoViewModel(),
          coordinator: coordinator,
          router: router
        )
        .tabItem {
          Image(uiImage: AssetImage.tabMyinfo.image)
          Text("내정보")
        }
        .tag(Router.Tab.myInfo)
      }
      .tabViewTintColor(tintColor: .seSACGreen)
    }
  }

  init(router: HomeTapView.Router, coordinator: Coordinator?) {
    self.router = router
    self.coordinator = coordinator
  }
}
protocol SwiftUIRouter { }
extension HomeTapView {
  final class Router: SwiftUIRouter, ObservableObject {

    enum Tab {
      case home
      case shop
      case freinds
      case myInfo
    }

    @Published var tab: Tab = .home
    @Published var showProfileView = false
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
    let routerSpy = HomeTapView.Router()
    HomeTapView(router: routerSpy, coordinator: nil)
  }
}

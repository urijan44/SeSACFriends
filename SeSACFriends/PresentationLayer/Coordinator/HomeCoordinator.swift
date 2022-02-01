//
//  HomeCoordinator.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/01.
//

import UIKit
import SwiftUI

final class HomeCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router

  lazy var homeView = UIHostingController(rootView: HomeViewTest())

  init(router: Router) {
    self.router = router
  }

  func present(animated: Bool, onDismissed: (() -> Void)?) {
    router.present(homeView, animated: animated)
  }
}

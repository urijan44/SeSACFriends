//
//  HomeCoordinator.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/01.
//

import UIKit
import SwiftUI

final class HomeCoordinator: Coordinator {
  var router: Router

  var children: [Coordinator] = []
  var rootView: UINavigationController?

//  lazy var homeView = HomeViewController()
  lazy var homeView = UIHostingController(rootView: HomeViewTest())

  init(router: Router, rootView: UINavigationController) {
    self.rootView = rootView
    self.router = router
  }

  func present(animated: Bool, onDismissed: (() -> Void)?) {
    guard let router = router as? OnBoardingNavigationRouter else { return }
    router.start(homeView, animated: true, onDismissed: nil)
    router.navigationController.navigationBar.isHidden = true
    router.navigationController.isNavigationBarHidden = true
    router.navigationController.setNavigationBarHidden(true, animated: false)
  }
}

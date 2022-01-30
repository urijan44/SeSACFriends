//
//  OnboardingCoordinator.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import UIKit

final class AppDelegateCoordinator: Coordinator {
  var children: [Coordinator] = []
  let router: Router

  init(router: Router) {
    self.router = router
  }

  func present(animated: Bool, onDismissed: (() -> Void)?) {
    //계정 정보 없으면 -> 온보딩 코디
    startOnBoardingCoordinator()
    //계정 정보 있으면 -> 홈텝 코디
    //startHomeTapCoordinator()
  }

  func startOnBoardingCoordinator() {
    guard let router = (self.router as? AppDelegateRouter) else { return }
    let navigationController = router.navigationController
    router.start()
    let childRouter = OnBoardingNavigationRouter(navigationController: navigationController)
    let coordinator = OnBoardingCoordinator(router: childRouter)
    presentChild(coordinator, animated: true)
  }
}

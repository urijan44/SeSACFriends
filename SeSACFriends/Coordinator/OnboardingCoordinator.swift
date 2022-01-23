//
//  OnboardingCoordinator.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import UIKit

final class OnboardingCoordinator: Coordinator {
  var children: [Coordinator] = []
  let router: Router

  init(router: Router) {
    self.router = router
  }

  func present(animated: Bool, onDismissed: (() -> Void)?) {
    //Call UserSession Repository
    //if has idToken -> Main
    //else dosent have idToken but, Phont Auth -> SignUp
    //Nothing else -> Weolcome -> Phone Auth

    let view = WelcomeViewController()
    router.present(view, animated: true)
  }
}

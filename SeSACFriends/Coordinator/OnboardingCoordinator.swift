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

  lazy var welcomeView = WelcomeViewController(viewModel: WelcomeViewModel(), delegate: self)
  lazy var phoneAuthView = makePhoneAuthView()

  init(router: Router) {
    self.router = router
  }

  func present(animated: Bool, onDismissed: (() -> Void)?) {
    //Call UserSession Repository
    //if has idToken -> Main
    //else dosent have idToken but, Phont Auth -> SignUp
    //Nothing else -> Weolcome -> Phone Auth
//    if let _ = UserDefaults.standard.string(forKey: "idToken") {
//
//    } else {
//
//    }
    router.present(welcomeView, animated: true)
  }

  //MARK: - DI Container Class
  private func makePhoneAuthView() -> PhoneAuthViewController {
    let viewModel = PhoneAuthViewModel(coordinator: self, useCase: PhoneAuthUseCase())
    let controller = PhoneAuthViewController(viewModel: viewModel)
    return controller
  }

}

extension OnboardingCoordinator: WelcomeViewControllerDelegate {
  func startonBoardingButton() {
    router.present(phoneAuthView, animated: true)
  }
}

//extension OnboardingCoordinator:

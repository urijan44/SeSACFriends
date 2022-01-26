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
  lazy var welcomeView = WelcomeViewController(viewModel: WelcomeViewModel(), delegate: self)
  lazy var phoneAuthView = makePhoneAuthView()

  init(router: Router) {
    self.router = router
  }

  func present(animated: Bool, onDismissed: (() -> Void)?) {
    router.present(welcomeView, animated: true)
  }

  func phoneAuthVetificationCodeCheck() {
    guard let navigationController = (self.router as? AppDelegateRouter)?.navigationController else { return }
    let router = OnBoardingNavigationRouter(navigationController: navigationController)
    let coordinator = OnBoardingCoordinator(router: router)
    presentChild(coordinator, animated: true)
  }

  //MARK: - DI Container Class
  private func makePhoneAuthView() -> PhoneAuthViewController {
//    let viewModel = PhoneAuthViewModel(coordinator: self, useCase: PhoneAuthUseCase())
    let viewModel = PhoneAuthViewModel(useCase: PhoneAuthUseCase())
    let rootView = PhoneAuthMainView(viewModel: viewModel, delegate: self)
    let controller = PhoneAuthViewController(rootView: rootView)
    return controller
  }

}

extension AppDelegateCoordinator: WelcomeViewControllerDelegate {
  func startonBoardingButton() {
    //rootView phoneAuth or, signup 분기처리 가능
    router.present(phoneAuthView, animated: true)
  }
}

extension AppDelegateCoordinator: PhoneAuthMainViewDelegate {
  func phoneAuthMainViewPushVerificationCodeView() {
    guard let navigationController = (self.router as? AppDelegateRouter)?.navigationController else { return }
    let router = OnBoardingNavigationRouter(navigationController: navigationController)
    let coordinator = OnBoardingCoordinator(router: router)
    presentChild(coordinator, animated: true)
  }
}

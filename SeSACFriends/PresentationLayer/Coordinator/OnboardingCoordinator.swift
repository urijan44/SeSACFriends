//
//  OnBoardingCoordinator.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import UIKit

final class OnBoardingCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  lazy var validateCodeCheckView = makeValidateCodeCheckView()
  init(router: Router) {
    self.router = router
  }

  func present(animated: Bool, onDismissed: (() -> Void)?) {
    router.present(validateCodeCheckView, animated: true)
  }

  private func makeValidateCodeCheckView() -> ValidateCodeCheckViewController {
    let viewModel = ValidateCodeCheckViewModel(useCase: ValidateCodeUseCase())
    let rootView = ValidateCodeCheckView(viewModel: viewModel, delegate: self)
    let controller = ValidateCodeCheckViewController(rootView: rootView)
    return controller
  }
}

extension OnBoardingCoordinator: ValidateCodeCheckViewDeledage {
  func navigatorPush() {

  }

  func navigatorPop() {
    router.dismiss(animated: true)
  }
}

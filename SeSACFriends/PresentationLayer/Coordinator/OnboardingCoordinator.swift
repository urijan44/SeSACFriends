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
    let viewModel = ValidateCodeCheckViewModel()
    let rootView = ValidateCodeCheckView(viewModel: viewModel)
    let controller = ValidateCodeCheckViewController(rootView: rootView)
    return controller
  }
}

//MARK: - Factory

//
//  OnBoardingNavigationRouter.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import UIKit

final class OnBoardingNavigationRouter: NSObject {
  private let navigationController: UINavigationController
  private var routerRootController: UIViewController?
  private var onDismissForViewController: [UIViewController: (() -> Void)] = [:]

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.routerRootController = navigationController.viewControllers.first
    super.init()
    self.navigationController.delegate = self
  }
}

extension OnBoardingNavigationRouter: Router {
  func start(_ viewController: UIViewController, animated: Bool) {
    routerRootController = viewController
    navigationController.setViewControllers([viewController], animated: animated)
  }

  func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    if navigationController.viewControllers.isEmpty {
      start(viewController, animated: animated)
    } else {
      onDismissForViewController[viewController] = onDismissed
      navigationController.pushViewController(viewController, animated: animated)
    }
  }

  func changeRootPresent(_ viewController: UIViewController, animated: Bool = false, onDismissed: (() -> Void)?) {
//    UIView.transition(with: viewController, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)

    navigationController.setViewControllers([viewController], animated: true)
  }

  func dismiss(animated: Bool) {
    guard let routerRootController = routerRootController else {
      navigationController.popToRootViewController(animated: animated)
      return
    }
    performOnDismissed(for: routerRootController)
    navigationController.popToViewController(routerRootController, animated: animated)
  }

  private func performOnDismissed(for viewController: UIViewController) {
    guard let onDismiss = onDismissForViewController[viewController] else {
      return
    }
    onDismiss()
    onDismissForViewController[viewController] = nil
  }
}

extension OnBoardingNavigationRouter: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    guard let dismisstedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
          !navigationController.viewControllers.contains(dismisstedViewController) else { return }
    performOnDismissed(for: dismisstedViewController)
  }
}

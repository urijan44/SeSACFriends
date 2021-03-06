//
//  OnBoardingNavigationRouter.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import UIKit

final class OnBoardingNavigationRouter: NSObject {
  let navigationController: UINavigationController
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
  func start(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    routerRootController = viewController
    navigationController.setViewControllers([viewController], animated: animated)
    onDismissForViewController[viewController] = onDismissed
  }

  func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    if navigationController.viewControllers.isEmpty {
      start(viewController, animated: animated, onDismissed: onDismissed)
    } else {
      onDismissForViewController[viewController] = onDismissed
      navigationController.pushViewController(viewController, animated: animated)
    }
  }

  func changeRootPresent(from: UIViewController, _ viewController: UIViewController, animated: Bool = false) {
    navigationController.setViewControllers([viewController], animated: true)
    routerRootController = viewController
    copyOnDismissHandler(from: from, to: viewController)
  }

  func dismiss(animated: Bool) {
    guard let routerRootController = routerRootController else {
      navigationController.popToRootViewController(animated: animated)
      return
    }
    performOnDismissed(for: routerRootController)
  }

  private func performOnDismissed(for viewController: UIViewController) {
    guard let onDismiss = onDismissForViewController[viewController] else {
      return
    }
    onDismiss()
    onDismissForViewController[viewController] = nil
  }

  func copyOnDismissHandler(from: UIViewController, to: UIViewController) {
    if let action = onDismissForViewController[from] {
      onDismissForViewController[to] = action
      onDismissForViewController[from] = nil
    }
  }
}

extension OnBoardingNavigationRouter: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    guard let dismisstedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
          !navigationController.viewControllers.contains(dismisstedViewController) else { return }
    performOnDismissed(for: dismisstedViewController)
  }
}

//
//  EmbedNavigationRouter.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import UIKit

final class EmbedNavigationRouter: NSObject {
  unowned let parentViewController: UIViewController
  private let navigationController = UINavigationController()
  private var onDismissForViewController: [UIViewController: (() -> Void)] = [:]

  init(parentViewController: UIViewController) {
    self.parentViewController = parentViewController
    super.init()
    navigationController.delegate = self
  }
}

extension EmbedNavigationRouter: Router {
  func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    onDismissForViewController[viewController] = onDismissed
    if navigationController.viewControllers.isEmpty {
      present(viewController, animated: animated)
    } else {
      navigationController.pushViewController(viewController, animated: animated)
    }
  }

  func presentModally(_ viewController: UIViewController, animated: Bool) {

  }

  func dismiss(animated: Bool) {
    guard let viewController = navigationController.viewControllers.first else { fatalError("Empty Navigation Stack!") }
    performOnDismissed(for: viewController)
    parentViewController.dismiss(animated: animated, completion: nil)
  }

  private func performOnDismissed(for viewController: UIViewController) {
    guard let onDismiss = onDismissForViewController[viewController] else { return }
    onDismiss()
    onDismissForViewController[viewController] = nil
  }
}

extension EmbedNavigationRouter: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController,
                                   didShow viewController: UIViewController,
                                   animated: Bool) {
    guard let dismissedViewController =
            navigationController.transitionCoordinator?.viewController(forKey: .from),
          !navigationController.viewControllers.contains(dismissedViewController) else {
      return
    }
    performOnDismissed(for: dismissedViewController)
  }
}

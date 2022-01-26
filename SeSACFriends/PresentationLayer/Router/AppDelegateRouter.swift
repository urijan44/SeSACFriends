//
//  AppDelegateRouter.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import UIKit

class AppDelegateRouter: Router {
  let window: UIWindow
  let navigationController = UINavigationController()
  init(window: UIWindow) {
    self.window = window
  }

  func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    navigationController.setViewControllers([viewController], animated: false)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    UIView.transition(
      with: window,
      duration: 0.5,
      options: .transitionCrossDissolve,
      animations: nil)
  }

  func dismiss(animated: Bool) {
    fatalError("AppDelegateRouter Can not dismiss")
  }
}

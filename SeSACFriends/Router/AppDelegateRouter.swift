//
//  AppDelegateRouter.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import UIKit

class AppDelegateRouter: Router {
  let window: UIWindow

  init(window: UIWindow) {
    self.window = window
  }

  func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    window.rootViewController = viewController
    window.makeKeyAndVisible()
    UIView.transition(
      with: window,
      duration: 0.5,
      options: .transitionCrossDissolve,
      animations: nil)
  }

  func dismiss(anmiated: Bool) {
    fatalError("AppDelegateRouter Can not dismiss")
  }
}

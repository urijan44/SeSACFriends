//
//  Router.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/22.
//

import UIKit

protocol Router: AnyObject {
  func present(_ viewController: UIViewController, animated: Bool)
  func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?)
  func dismiss(anmiated: Bool)
}

extension Router {
  func present(_ viewController: UIViewController, animated: Bool) {
    present(viewController, animated: animated, onDismissed: nil)
  }
}

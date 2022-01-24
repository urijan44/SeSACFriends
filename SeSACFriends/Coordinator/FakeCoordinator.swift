//
//  FateCoordinator.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import UIKit

final class FakeCoordinator: Coordinator {
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    //donothing
  }

  var children: [Coordinator] = []
  let router: Router

  init(router: Router = FakeRouter()) {
    self.router = router
  }

}

final class FakeRouter: Router {
  func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    //donothing
  }

  func dismiss(animated: Bool) {
    //donothing
  }
}

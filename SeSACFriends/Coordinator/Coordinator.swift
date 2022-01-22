//
//  Coordinator.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/22.
//

import UIKit

protocol Coordinator: AnyObject {
  var children: [Coordinator] { get set }
  var router: Router { get }

  func present(animated: Bool, onDismissed: (()->Void)?)
  func dismiss(animated: Bool)

  func presentChild(_ child: Coordinator, animated: Bool)
  func presentChild(_ child: Coordinator, animated: Bool, onDismissed: (()->Void)?)
}

extension Coordinator {
  func dimsiss(animated: Bool) {
    router.dismiss(anmiated: animated)
  }

  func presentChild(_ child: Coordinator, animated: Bool) {
    presentChild(child, animated: animated, onDismissed: nil)
  }

  func presentChild(_ child: Coordinator, animated: Bool, onDismissed: (()->Void)?) {
    children.append(child)
    child.present(animated: animated) { [weak self, weak child ] in
      guard let self = self, let child = child else { return }
      self.removeChild(child)
      onDismissed?()
    }
  }

  func removeChild(_ child: Coordinator) {
    guard let index = children.firstIndex(where: { $0 === child }) else { return }
    children.remove(at: index)
  }
}

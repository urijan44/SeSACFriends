//
//  EmailViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/31.
//

import UIKit
import SeSACFriendsUIKit

final class EmailViewController: NiblessViewController {
  let rootView: EmailRootView

  init(rootView: EmailRootView) {
    self.rootView = rootView
    super.init()
  }

  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem = rootView.leftBarButtonItem
  }
}

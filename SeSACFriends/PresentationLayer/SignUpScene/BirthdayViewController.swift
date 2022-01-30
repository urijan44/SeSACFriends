//
//  BirthdayViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/30.
//

import UIKit
import SeSACFriendsUIKit

final class BirthdayViewController: NiblessViewController {
  let rootView: BirthdayRootView

  init(rootView: BirthdayRootView) {
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

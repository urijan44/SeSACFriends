//
//  NicknameViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/28.
//

import UIKit
import SeSACFriendsUIKit

final class NicknameViewController: NiblessViewController {
  let rootView: NicknameRootView

  init(rootView: NicknameRootView) {
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

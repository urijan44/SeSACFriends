//
//  GenderViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/31.
//

import Foundation
import SeSACFriendsUIKit

final class GenderViewController: NiblessViewController {
  let rootView: GenderRootView

  init(rootView: GenderRootView) {
    self.rootView = rootView
    super.init()
  }

  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    navigationItem.leftBarButtonItem = rootView.leftBarButtonItem
  }
}

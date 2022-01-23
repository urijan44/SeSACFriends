//
//  WelcomView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/23.
//

import UIKit
import SnapKit
import SeSACFriendsUIKit

class WelcomeViewController: UIViewController {

  let mainView = WelcomeRootView()

  override func loadView() {
    view = mainView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

  }
}

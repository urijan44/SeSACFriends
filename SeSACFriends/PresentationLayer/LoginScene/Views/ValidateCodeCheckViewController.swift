//
//  ValidateCodeCheckViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import UIKit
import SeSACFriendsUIKit

class ValidateCodeCheckViewController: RepresentableViewController {

  let rootView: ValidateCodeCheckView

  init(rootView: ValidateCodeCheckView) {
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

//
//  ViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/18.
//

import UIKit
import SeSACFriendsUIKit

class PhoneAuthViewController: RepresentableViewController {

  let rootView: PhoneAuthMainView

  init(rootView: PhoneAuthMainView) {
    self.rootView = rootView
    super.init()
  }

  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    rootView.textField.becomeFirstResponder()
  }
}

//
//  ViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/18.
//

import UIKit
import SeSACFriendsUIKit

class PhoneAuthViewController: UIViewController {

  let mainView = PhoneAuthMainView()

  override func loadView() {
    view = mainView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

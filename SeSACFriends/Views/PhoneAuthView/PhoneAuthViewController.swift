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
    mainView.button.addAction(UIAction() { _ in
      if self.mainView.textField.fieldState == .success {
        self.mainView.textField.fieldState = .inactive
      } else {
        self.mainView.textField.fieldState = .success
      }
    }, for: .touchUpInside)
  }
}

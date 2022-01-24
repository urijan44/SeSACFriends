//
//  ViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/18.
//

import UIKit
import SeSACFriendsUIKit

class PhoneAuthViewController: RepresentableViewController {

  let viewModel: PhoneAuthViewModel
  let rootView: PhoneAuthMainView

  init(viewModel: PhoneAuthViewModel) {
    self.viewModel = viewModel
    self.rootView = PhoneAuthMainView(viewModel: viewModel)
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

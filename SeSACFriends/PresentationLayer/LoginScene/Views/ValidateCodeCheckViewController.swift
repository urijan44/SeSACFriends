//
//  ValidateCodeCheckViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import UIKit
import SeSACFriendsUIKit

class ValidateCodeCheckViewController: RepresentableViewController {

  let viewModel: ValidateNumberCheckViewModel
  let rootView: ValidateNumberCheckView

  init(viewModel: ValidateNumberCheckViewModel) {
    self.viewModel = viewModel
    self.rootView = ValidateNumberCheckView(viewModel: viewModel)
    super.init()
  }

  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

//
//  HomeViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/06.
//

import UIKit
import SwiftUI
import SeSACFriendsUIKit

final class HomeRootView: RepresentableView {
  let hosting = UIHostingController(rootView: HomeViewTest())

  override func createView() {
    addSubview(hosting.view)
  }

  override func layoutConfigure() {
    hosting.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

final class HomeViewController: RepresentableViewController {

  let rootView = HomeRootView()

  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = true
  }
}

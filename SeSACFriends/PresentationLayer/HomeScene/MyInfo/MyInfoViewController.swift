//
//  MyInfoViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/05.
//

import UIKit
import SwiftUI
import SeSACFriendsUIKit

final class MyInfoViewRootView: RepresentableView {

  let hostingView = UIHostingController(rootView: MyInfoView())

  override func createView() {
    addSubview(hostingView.view)
  }

  override func layoutConfigure() {
    hostingView.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

}

final class MyInfoViewController: RepresentableViewController {

  let rootView = MyInfoViewRootView()

  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

struct MyInfoViewControllerRP: UIViewControllerRepresentable {
  func makeUIViewController(context: UIViewControllerRepresentableContext<MyInfoViewControllerRP>) -> MyInfoViewController {
    return MyInfoViewController()
  }

  func updateUIViewController(_ uiViewController: MyInfoViewController, context: Context) {

  }
}

//
//  FriendListViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/03/04.
//

import UIKit
import SeSACFriendsUIKit
import SnapKit
import SwiftUI

final class FriendListViewController: UIViewController {

  let button = SeSACButton(style: .fill)

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(button)

    button.snp.makeConstraints { make in
      make.width.equalTo(88)
      make.height.equalTo(44)
      make.center.equalToSuperview()
    }

    button.addTarget(self, action: #selector(progressTest(_:)), for: .touchUpInside)
  }

  @objc func progressTest(_ sender: SeSACButton) {
    button.isProgress = true

    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.button.isProgress = false
    }
  }
}

struct FriendListViewSU: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> FriendListViewController {
    FriendListViewController()
  }

  func updateUIViewController(_ uiViewController: FriendListViewController, context: Context) {

  }
}

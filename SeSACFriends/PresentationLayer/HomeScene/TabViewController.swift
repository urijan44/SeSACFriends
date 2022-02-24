//
//  TabViewController.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/25.
//

import UIKit
import SwiftUI

final class TabViewController: RepresentableViewController {

  let rootView = UIHostingController(rootView: HomeViewTest())

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(rootView.view)
    rootView.view.snp.makeConstraints { make in
      make.edges.equalTo(view.snp.edges)
    }
    view.backgroundColor = .systemTeal
    navigationController?.title = "fdasjfk"
  }
}

//
//  WelcomeView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/23.
//

import UIKit
import SeSACFriendsUIKit
import SnapKit

final class WelcomeRootView: RepresentableView {

  lazy var pageView = WelcomePageView()
  lazy var hosting = UIHostingController(rootView: pageView)
  lazy var pageViewContainer = UIView()

  lazy var startButton = SeSACButton(style: .fill).then {
    $0.title = "시작하기"
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func createView() {
    super.createView()
    addSubview(pageViewContainer)
    pageViewContainer.addSubview(hosting.view)
    addSubview(startButton)
  }

  override func layoutConfigure() {
    super.layoutConfigure()

    pageViewContainer.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.bottom.equalTo(startButton.snp.top).offset(-42)
    }

    startButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(48)
      make.bottom.equalToSuperview().offset(-50)
    }

    hosting.view.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
      make.top.equalToSuperview()
    }
  }
}

#if DEBUG
import SwiftUI
fileprivate struct WelcomeRootViewRp: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<WelcomeRootViewRp>) -> WelcomeRootView {
    WelcomeRootView()
  }

  func updateUIView(_ uiView: WelcomeRootView, context: Context) {
    
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeRootViewRp()
  }
}

#endif

//
//  WelcomeView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/23.
//

import UIKit
import SeSACFriendsUIKit
import SnapKit
import RxSwift
import RxCocoa

final class WelcomeRootView: RepresentableView {

  let viewModel: WelcomeViewModel
  let bag = DisposeBag()
  lazy var pageView = WelcomePageView()
  lazy var hosting = UIHostingController(rootView: pageView)
  lazy var pageViewContainer = UIView()

  lazy var startButton = SeSACButton(style: .fill).then {
    $0.title = "시작하기"
  }

  private let screenReader = UIScreen.main.bounds

  init(frame: CGRect = .zero,
       viewModel: WelcomeViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
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
      make.bottom.equalTo(startButton.snp.top).offset(screenReader.height * -0.058)
    }

    startButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(48)
      make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
    }

    hosting.view.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
      make.top.equalTo(safeAreaLayoutGuide.snp.top)
    }
  }
}

#if DEBUG
import SwiftUI
fileprivate struct WelcomeRootViewRp: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<WelcomeRootViewRp>) -> WelcomeRootView {
    WelcomeRootView(viewModel: .init())
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

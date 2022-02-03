//
//  WelcomeImageView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import UIKit
import SwiftUI
import SeSACFriendsUIKit
import SnapKit
import Then

final class WelcomeImageView: RepresentableView {

  let titleImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  let bodyImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  private let screenReader = UIScreen.main.bounds

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func createView() {
    super.createView()
    addSubview(titleImageView)
    addSubview(bodyImageView)
  }

  override func layoutConfigure() {
    super.layoutConfigure()
    titleImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(snp.top).offset(screenReader.height * 0.088)
      make.width.equalTo(205)
      make.height.equalTo(76)
    }

    bodyImageView.snp.makeConstraints { make in
      make.top.equalTo(titleImageView.snp.bottom).offset(screenReader.height * 0.068)
      make.width.height.equalTo(snp.width).multipliedBy(0.96)
    }
  }
}

extension WelcomeImageView {
  convenience init(title: UIImage, body: UIImage) {
    self.init()
    self.titleImageView.image = title
    self.bodyImageView.image = body
  }
}

struct WelcomeImageViewRP: UIViewRepresentable {

  let titleImage: UIImage
  let bodyImage: UIImage

  func makeUIView(context: UIViewRepresentableContext<WelcomeImageViewRP>) -> WelcomeImageView {
    WelcomeImageView(title: titleImage, body: bodyImage)
  }

  func updateUIView(_ uiView: WelcomeImageView, context: Context) {

  }
}

//struct WelcomeImageView_Previews: PreviewProvider {
//  static var previews: some View {
//    WelcomeImageViewRP(
//      titleImage: .onboardingText1.image,
//      bodyImage: AssetImage.onboardingImg1.image)
//  }
//}

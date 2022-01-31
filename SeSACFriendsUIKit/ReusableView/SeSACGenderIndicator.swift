//
//  SeSACGenderIndicator.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/31.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final public class SeSACGenderIndicator: UIControl {

  public enum Gender: Int{
    case male = 1
    case female = -1
  }

  public override var isSelected: Bool {
    didSet {
      updateUI()
    }
  }

  private let genderImage = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  private let label = UILabel(typoStyle: .title2).then {
    $0.textAlignment = .center
  }
  private var gender: Gender {
    didSet {
      updateUI()
    }
  }

  override init(frame: CGRect) {
    gender = .female
    super.init(frame: frame)
    createView()
    updateUI()
  }

  init(frame: CGRect = .zero, gender: Gender) {
    self.gender = gender
    super.init(frame: frame)
    createView()
    updateUI()
  }

  required init?(coder: NSCoder) {
    fatalError("Unsupported Intialize")
  }

  private func updateUI() {
    if gender == .male {
      genderImage.image = Images.man.image
      label.text = "남자"
    } else {
      genderImage.image = Images.woman.image
      label.text = "여자"
    }

    if isSelected {
      backgroundColor = .seSACWhiteGreen
      layer.borderWidth = 0
    } else {
      backgroundColor = .seSACWhite
      layer.borderWidth = 1
      layer.borderColor = .seSACGray3
    }
  }

  private func createView() {
    layer.cornerRadius = 8
    layer.borderWidth = 1
    addSubview(genderImage)
    addSubview(label)
    layoutConfigure()
  }

  private func layoutConfigure() {
    genderImage.snp.makeConstraints { make in
      make.size.equalTo(snp.height).multipliedBy(0.55)
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(14)
    }

    label.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.centerX.equalToSuperview()
      make.top.equalTo(genderImage.snp.bottom).offset(2)
    }
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 8
    layer.borderColor = .seSACGray3
  }
}

extension Reactive where Base: SeSACGenderIndicator {
  public var tap: ControlEvent<Void> {
    return base.rx.controlEvent(.touchUpInside)
  }
}

#if DEBUG
import SwiftUI
fileprivate struct SeSACGenderIndicatorRP: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<SeSACGenderIndicatorRP>) -> SeSACGenderIndicator {
    SeSACGenderIndicator()
  }

  func updateUIView(_ uiView: SeSACGenderIndicator, context: Context) {

  }
}

struct SeSACGenderIndicatorRP_Previews: PreviewProvider {
  static var previews: some View {
    SeSACGenderIndicatorRP()
      .previewLayout(.sizeThatFits)
      .frame(width: 166, height: 120)
  }
}
#endif

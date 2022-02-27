//
//  SeSACGenderIndicator.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/31.
//

import UIKit

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

  private let genderImage: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    return view
  }()

  private let label: UILabel = {
    let label = UILabel(typoStyle: .title2)
    label.textAlignment = .center
    return label
  }()
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
      genderImage.image = AssetImage.man.image
      label.text = "남자"
    } else {
      genderImage.image = AssetImage.woman.image
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
    layer.cornerRadius = Constant.cornerRadius
    layer.borderWidth = 1
    addSubview(genderImage)
    addSubview(label)
    layoutConfigure()
  }

  private func layoutConfigure() {
    genderImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      genderImage.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55),
      genderImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55),
      genderImage.centerXAnchor.constraint(equalTo: centerXAnchor),
      genderImage.topAnchor.constraint(equalTo: topAnchor, constant: 14)
    ])

    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
      label.centerXAnchor.constraint(equalTo: centerXAnchor),
      label.topAnchor.constraint(equalTo: genderImage.bottomAnchor, constant: 2)
    ])
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 8
    layer.borderColor = .seSACGray3
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

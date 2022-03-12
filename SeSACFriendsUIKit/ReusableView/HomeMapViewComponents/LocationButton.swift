//
//  LocationButton.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/28.
//

import UIKit
import LeafLayoutKit

public final class LocationButton: UIControl {

  private let imageView: UIImageView = {
    let view = UIImageView(image: AssetImage.place.image)
    view.tintColor = .seSACBlack
    return view
  }()

  public override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layer.cornerRadius = Constant.cornerRadius
    
    createView()
    layoutConfigure()
    layer.shadowColor = .seSACBlack
    layer.shadowRadius = 1
    layer.shadowOffset = .init(width: 0, height: 1)
    layer.shadowOpacity = 0.5
  }

  public required init?(coder: NSCoder) {
    fatalError("Unsupported Intializer")
  }

  private func createView() {
    addSubview(imageView)
  }

  private func layoutConfigure() {
    imageView.customLayout(self, [
      .width(constant: 20),
      .height(constant: 20),
      .centerX(constant: 0),
      .centerY(constant: 0)
    ])
  }

  private func touchAnimation() {

    UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) { [unowned self] in
      imageView.transform = .init(scaleX: 1.1, y: 1.1)
    }

    UIView.animate(withDuration: 0.3, delay: 0.15, options: .curveEaseIn) { [unowned self] in
      imageView.transform = .init(rotationAngle: .pi * 0.5)
    } completion: { [unowned self] _ in
      imageView.transform = .init(rotationAngle: 0)
    }
  }

  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    touchAnimation()
    sendActions(for: .touchUpInside)
  }
}

import SwiftUI

struct LocationButtonUI: UIViewRepresentable {
  func makeUIView(context: Context) -> LocationButton {
    LocationButton()
  }

  func updateUIView(_ uiView: LocationButton, context: Context) {

  }
}

struct LocationButtonUI_Previews: PreviewProvider {
  static var previews: some View {
    LocationButtonUI()
      .frame(width: 48, height: 48)
  }
}

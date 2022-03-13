//
//  MatchingStateButton.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/03/11.
//

import UIKit
import LeafLayoutKit

final public class MatchingStateButton: UIControl {

  enum MatchState {
    case `default`
    case matching
    case matched
  }

  var matchState: MatchState = .default {
    didSet {
      uiUpdate()
    }
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .seSACBlack
    createView()
    layer.shadowColor = .seSACBlack
    layer.shadowRadius = 1
    layer.shadowOffset = .init(width: 0, height: 1)
    layer.shadowOpacity = 0.5
  }

  public required init?(coder: NSCoder) {
    fatalError("Unsupprted Initializer")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = bounds.midX
  }

  private func createView() {
    addSubview(imageView)
    imageView.customLayout(self, [
      .width(constant: 40),
      .height(constant: 40),
      .centerX(constant: 0),
      .centerY(constant: 0)
    ])
  }

  private var imageView: UIImageView = {
    let view = UIImageView()
    view.tintColor = .white
    view.image = StateImage.defaultImage
    view.contentMode = .scaleAspectFit
    return view
  }()

  private func uiUpdate() {
    switch matchState {
      case .default:
        imageView.image = StateImage.defaultImage
      case .matching:
        imageView.image = StateImage.antennaImage
      case .matched:
        imageView.image = StateImage.matchedImage
    }
  }

  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    sendActions(for: .touchUpInside)
  }
}

private extension MatchingStateButton {
  private struct StateImage {
    static var defaultImage: UIImage {
      AssetImage.search.image
    }

    static var antennaImage: UIImage {
      AssetImage.antenna.image
    }

    static var matchedImage: UIImage {
      AssetImage.message.image
    }
  }
}

#if DEBUG

import SwiftUI

struct MatchingStateButtonView: UIViewRepresentable {
  func makeUIView(context: Context) -> MatchingStateButton {
    MatchingStateButton()
  }

  func updateUIView(_ uiView: MatchingStateButton, context: Context) {

  }
}

struct MatchingStateButton_Previews: PreviewProvider {
  static var previews: some View {
    MatchingStateButtonView()
      .frame(width: 56, height: 56)
      .previewLayout(.sizeThatFits)
  }
}

#endif

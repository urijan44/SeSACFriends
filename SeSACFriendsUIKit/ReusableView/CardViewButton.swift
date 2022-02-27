//
//  CardViewButton.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/10.
//

import SwiftUI

public struct CardViewButton: View {

  public enum CardStyle {
    case request
    case accept
  }

  public var cardStyle: CardStyle

  private var text: String {
    switch cardStyle {
      case .request:
        return "요청하기"
      case .accept:
        return "수락하기"
    }
  }

  private var color: Color {
    switch cardStyle {
      case .request:
        return Color(.seSACError)
      case .accept:
        return Color(.seSACSuccess)
    }
  }

  public var action: (() -> Void)? = nil

  public var body: some View {
    Button {
      action?()
    } label: {
      RoundedRectangle(cornerRadius: Constant.cornerRadius)
        .foregroundColor(color)
        .overlay(
          Text(text)
            .font(Font(uiFont: .title3m))
            .foregroundColor(Color(.seSACWhite))
      )
    }
  }

  public init(cardStyle: CardStyle, action: (() -> Void)? = nil) {
    self.cardStyle = cardStyle
    self.action = action
  }
}

struct CardViewButton_Previews: PreviewProvider {
  static var previews: some View {
    CardViewButton(cardStyle: .request)
      .frame(width: 80, height: 40)
      .previewLayout(.fixed(width: 80, height: 40))
    CardViewButton(cardStyle: .accept)
      .frame(width: 80, height: 40)
      .previewLayout(.fixed(width: 80, height: 40))
  }
}

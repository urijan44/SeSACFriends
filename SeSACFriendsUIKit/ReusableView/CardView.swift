//
//  CardView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/10.
//

import SwiftUI

public struct CardView: View {
  public enum CardState {
    case request
    case accept
  }

  public var cardState: CardState
  private var buttonState: CardViewButton.CardStyle {
    switch cardState {
      case .request:
        return .request
      case .accept:
        return .accept
    }
  }

  public var body: some View {
    ScrollView {
      ZStack {
        CardViewButton(cardStyle: buttonState, action: nil)
        Image(uiImage:   AssetImage.write.image)
      }
    }

  }

  public init(cardState: CardState) {
    self.cardState = cardState
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(cardState: .request)
  }
}

//
//  FavoriteHobby.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

public struct FavoriteHobby: View {
  @Binding var hobby: String
  public var body: some View {
    HStack {
      Text("자주 하는 취미")
        .font(Font(uiFont: .title4r))
        .foregroundColor(Color(.seSACBlack))
      Spacer()
      ZStack() {
        TextField("" ,text: $hobby)
          .font(Font(uiFont: .title4r))
          .frame(height: 48)
          .padding(.horizontal, 12)
        VStack {
          Rectangle()
            .foregroundColor(Color(.seSACGray4))
            .frame(height: 1, alignment: .bottom)
            .padding(.top, 48)
        }
      }
      .frame(maxWidth: 164)
    }
  }

  public init(hobby: Binding<String>) {
    self._hobby = hobby
  }
}

struct FavoriteHobby_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteHobby(hobby: .constant("뜨개질"))
  }
}

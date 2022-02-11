//
//  SeSACTitleView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

internal struct SeSACTitleView: View {
  @Binding var titles: [SeSACTitle]
  var titleColumns: [GridItem] {
    [
      GridItem(.flexible(minimum: 151, maximum: UIScreen.main.bounds.width), spacing: 8),
      GridItem(.flexible(minimum: 151, maximum: UIScreen.main.bounds.width), spacing: 8),
    ]
  }
  var body: some View {
    VStack {
      Text("새싹 타이틀")
        .font(Font(uiFont: .title6r))
        .foregroundColor(Color(.seSACBlack))
        .frame(maxWidth: .infinity, alignment: .leading)
      LazyVGrid(columns: titleColumns) {
        ForEach($titles, id: \.self) { sesacTitle in
          TitleButton(check: sesacTitle.check, text: sesacTitle.title)
            .frame(height: 32)
        }
      }
    }
  }
}

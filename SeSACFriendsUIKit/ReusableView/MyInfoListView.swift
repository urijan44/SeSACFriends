//
//  MyInfoListView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/02.
//

import SwiftUI

public struct MyInfoListView: View {
  var image: UIImage
  var title: String

  public var body: some View {
    GeometryReader { proxy in
      HStack(spacing: 12) {
        Image(uiImage: image)
          .resizable()
          .frame(width: 24, height: 24, alignment: .center)
        Text(title)
          .font(.init(uiFont: .title2r))
      }
      .padding([.top, .bottom], 12)
    }
  }
}

struct MyInfoListView_Previews: PreviewProvider {
  static var previews: some View {
    MyInfoListView(image: Images.notice.image, title: "공지사항")
  }
}

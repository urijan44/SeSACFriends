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

  public init(image: UIImage, title: String) {
    self.image = image
    self.title = title
  }

  public var body: some View {
      HStack(spacing: 12) {
        Image(uiImage: image)
          .resizable()
          .frame(width: 24, height: 24, alignment: .center)
        Text(title)
          .font(.init(uiFont: .title2r))
      .padding([.top, .bottom], 12)
    }
    .frame(height: 78, alignment: .center)

  }
}

struct MyInfoListView_Previews: PreviewProvider {
  static var previews: some View {
    MyInfoListView(image: AssetImage.notice.image, title: "공지사항")
  }
}

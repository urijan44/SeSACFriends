//
//  CardView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/10.
//

import SwiftUI
import Combine

public struct SeSACTitle: Identifiable, Hashable {
  public var id = UUID().uuidString
  var title: String
  var check: Bool = false
}

public struct CardView: View {

  private var backgroundImage: Image
  private var faceImage: Image
  private var name: String
  @State public var title: [SeSACTitle] = [
   .init(title: "좋은 매너"),
   .init(title: "정확한 시간 약속"),
   .init(title: "빠른 응답"),
   .init(title: "친절한 성격"),
   .init(title: "능숙한 취미 실력"),
   .init(title: "유익한 시간"),
  ]
  private var hobby: [String]
  private var review: [String]
  
  public var body: some View {
    VStack {
      ZStack(alignment: .bottom) {
        backgroundImage
        faceImage
          .offset(y: 4)
      }
      .cornerRadius(8)
      CardDetailView(titles: $title, isSearchView: true)
    }
  }

  public init(
    backgroundImage: Image,
    faceImage: Image,
    name: String,
    title: [SeSACTitle],
    hobby: [String],
    review: [String]
  ) {
    self.backgroundImage = backgroundImage
    self.faceImage = faceImage
    self.name = name
    self.title = title
    self.hobby = hobby
    self.review = review
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(
      backgroundImage: Image(uiImage: AssetImage.sesacBackground1.image),
      faceImage: Image(uiImage: AssetImage.sesacFace1.image),
      name: "김새싹",
      title: [
        .init(title: "좋은 매너"),
        .init(title: "정확한 시간 약속"),
        .init(title: "빠른 응답"),
        .init(title: "친절한 성격"),
        .init(title: "능숙한 취미 실력"),
        .init(title: "유익한 시간"),
       ],
      hobby: ["달리기", "뜨개질", "산책"],
      review: []
    )
  }
}

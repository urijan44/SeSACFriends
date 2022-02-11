//
//  CardView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/10.
//

import SwiftUI
import Combine

public struct CardView: View {

  private var backgroundImage: Image
  private var faceImage: Image
  private var name: String
  @Binding public var title: [ConvertedTitle]
  private var hobbies: [String]
  private var reviews: [String]
  private var isSearchView: Bool
  public var body: some View {
    VStack {
      ZStack(alignment: .bottom) {
        backgroundImage
          .resizable()
          .aspectRatio(contentMode: .fit)
        faceImage
          .aspectRatio(contentMode: .fit)
          .offset(y: 4)
      }
      .cornerRadius(8)
      CardDetailView(titles: $title, hobbies: hobbies, reviews: reviews, isSearchView: isSearchView)
    }
  }

  public init(
    backgroundImage: Image,
    faceImage: Image,
    name: String,
    title: Binding<[ConvertedTitle]>,
    hobbies: [String],
    reviews: [String],
    isSearchView: Bool
  ) {
    self.backgroundImage = backgroundImage
    self.faceImage = faceImage
    self.name = name
    self._title = title
    self.hobbies = hobbies
    self.reviews = reviews
    self.isSearchView = isSearchView
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(
      backgroundImage: Image(uiImage: AssetImage.sesacBackground1.image),
      faceImage: Image(uiImage: AssetImage.sesacFace1.image),
      name: "김새싹",
      title: .constant([]),
      hobbies: ["달리기", "뜨개질", "산책", "굉장히 굉장히 긴 취미 생활입니다"],
      reviews: ["리뷰를 썼습니다!"],
      isSearchView: true
    )
  }
}

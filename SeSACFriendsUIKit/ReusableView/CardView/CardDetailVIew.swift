//
//  CardDetailVIew.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

internal struct CardDetailView: View {
  @State var isDetailOpen: Bool = false
  @Binding var titles: [ConvertedTitle]
  var hobbies: [String]
  var reviews: [String]
  private var arrowDegree: Double {
    isDetailOpen ? 270 : 90
  }
  
  public var isSearchView: Bool

  var body: some View {
    VStack(spacing: 0) {
      HStack{
        Text("김새싹")
          .padding(16)
        Spacer()
        Button {
          withAnimation(.easeIn) {
            isDetailOpen.toggle()
          }
        } label: {
          Image(uiImage: AssetImage.moreArrow.image)
            .foregroundColor(Color(.seSACBlack))
            .padding(.horizontal, 16)
            .rotationEffect(.degrees(arrowDegree))
        }
      }
      if isDetailOpen {
        SeSACTitleView(titles: $titles)
          .padding(.horizontal, 16)
        if isSearchView {
          WantHobbyView(hobbies: hobbies, viewWidth: UIScreen.main.bounds.width - 32)
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
        }
        ReviewView(review: reviews.first ?? "")
        Spacer()
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 8)
        .strokeBorder(Color(.seSACGray1), lineWidth: 1)
    )
  }

  func ShowDetailView() -> some View {
    VStack {

    }
    .frame(maxHeight: isDetailOpen ? .infinity : .zero)
  }
}

struct CardDetailView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(
      backgroundImage: Image(uiImage: AssetImage.sesacBackground1.image),
      faceImage: Image(uiImage: AssetImage.sesacFace1.image),
      name: "김새싹",
      title: .constant([]),
      hobbies: ["달리기", "뜨개질", "산책"],
      reviews: [],
      isSearchView: true
    )
  }
}

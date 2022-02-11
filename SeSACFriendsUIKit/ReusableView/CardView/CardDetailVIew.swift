//
//  CardDetailVIew.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

internal struct CardDetailView: View {
  @State var isDetailOpen: Bool = true
  @Binding var titles: [SeSACTitle]

  private var arrowDegree: Double {
    isDetailOpen ? 270 : 90
  }
  
  public var isSearchView: Bool

  var body: some View {
    VStack {
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
          WantHobbyView()
        }
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 8)
        .strokeBorder(Color(.seSACGray1), lineWidth: 1)
    )
  }
}

struct CardDetailView_Previews: PreviewProvider {
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

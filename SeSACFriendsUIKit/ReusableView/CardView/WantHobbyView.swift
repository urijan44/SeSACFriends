//
//  WantHobbyView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

struct WantHobbyView: View {

  private var hobbies: [String] = ["코딩", "클라이밍",
                                   "엄청나게 긴 취미 이 취미는 도대체 무슨 취미일까취미일까취미일까취미일까취미일까취미일까",
                                   "테니스", "싸이클","게임", "만화", "춤"]
  var body: some View {
    GeometryReader { proxy in
      VStack() {
        Text("하고 싶은 취미")
          .font(Font(uiFont: .title6r))
          .foregroundColor(Color(.seSACBlack))
          .frame(maxWidth: .infinity, alignment: .leading)
        VStack(alignment: .leading) {
          ForEach(convertedHobbies(viewWidth: proxy.size.width), id: \.self) { rows in
            HStack {
              ForEach(rows, id: \.self) { hobby in
                HobbyTag(hobby: hobby)
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
      }
    }
    .padding(16)
  }

  func convertedHobbies(viewWidth: CGFloat) -> [[String]] {
    var rows: [[String]] = []
    var currentRow: [String] = []
    var totalWidth: CGFloat = 0

    self.hobbies.forEach { string in
      let textWidth = self.caculatingTextWidthSize(string) + 32
      totalWidth += textWidth
      if totalWidth > viewWidth {
        totalWidth = textWidth
        rows.append(currentRow)
        currentRow.removeAll()
        currentRow.append(string)
      } else {
        currentRow.append(string)
      }
    }

    if !currentRow.isEmpty {
      rows.append(currentRow)
    }

    return rows
  }

  private func caculatingTextWidthSize(_ text: String) -> CGFloat {
    let font = UIFont.title4r
    let attributes = [NSAttributedString.Key.font: font]
    let size = (text as NSString).size(withAttributes: attributes)

    return size.width
  }
}

struct HobbyTag: View {
  private var hobby: String

  var body: some View {
    Text(hobby)
      .font(Font(uiFont: .title4r))
      .lineLimit(1)
      .padding(.horizontal, 16)
      .padding(.vertical, 5)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .strokeBorder(
            Color(.seSACGray4),
            lineWidth: 1
          )
      )
  }

  init(hobby: String) {
    self.hobby = hobby
  }

}

struct WantHobbyView_Previews: PreviewProvider {
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

//
//  WantHobbyView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

struct WantHobbyView: View {
  var hobbies: [String]
  var viewWidth: CGFloat
  var body: some View {
    VStack() {
      Text("하고 싶은 취미")
        .font(Font(uiFont: .title6r))
        .foregroundColor(Color(.seSACBlack))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 16)
      VStack(alignment: .leading) {
        ForEach(convertedHobbies(viewWidth: viewWidth), id: \.self) { rows in
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
      name: .constant("김새싹"),
      title: .constant([]),
      hobbies: .constant(["달리기", "뜨개질", "산책"]),
      reviews: .constant(["나이키 에어맥스 96 운동화 구매후기 데일리룩 리뷰 이번주는 정말 상당히 추운 날씨가 계속해서 이어지고... 신발 리뷰입니다 구매는 사실 2021년도 7월에 해주게 되었던 제품인데 언제 올려야 하나 고민고민했다."]),
      isSearchView: true
    )
  }
}

//
//  MyInfoViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/02.
//

import UIKit
import SeSACFriendsUIKit

final class MyInfoViewModel {

  struct Info: Hashable, Identifiable {
    var id = UUID()

    let image: UIImage
    let title: String
  }

  var infolist: [Info] = [
    .init(image: AssetImage.notice.image, title: "공지사항"),
    .init(image: AssetImage.faq.image, title: "자주 묻는 질문"),
    .init(image: AssetImage.qna.image, title: "1:1 문의"),
    .init(image: AssetImage.notice.image, title: "알림 설정"),
    .init(image: AssetImage.permit.image, title: "이용 약관")
  ]

}

//
//  UserProfile.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/28.
//

import Foundation
import SeSACFriendsUIKit

struct UserProfile: Codable, UserStorage {
  var idToken: String = ""
  var id: String = ""
  var nickname: String = ""
  var birthday: Date = Date()
  var email: String = ""
  var gender: Int = -1
  var phoneNumber: String = ""
  var fcmToken: String = ""
  var hobby: String = ""
  var comment: [String] = []
  var reputation: [Int] = .init(repeating: 6, count: 0)
  var sesacFace: Int = 0
  var backgroundImage: Int = 0
  var searchable: Bool = false
  var ageMin: Int = 18
  var ageMax: Int = 65
}

extension UserProfile {
  func updateMyPage() -> [String: Any] {
    [
      "searchable": searchable ? 1 : 0,
      "ageMin": ageMin,
      "ageMax": ageMax,
      "gender": gender,
      "hobby": hobby
    ]
  }
}

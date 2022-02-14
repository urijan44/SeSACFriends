//
//  UserProfile.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/28.
//

import Foundation

struct UserProfile: Codable {
  var idToken: String?
  var nickname: String?
  var birthday: Date?
  var email: String?
  var gender: Int?
  var phoneNumber: String?
  var fcmToken: String?
  var hobby: String?
  var comment: [String] = []
  var reputation: [Int] = .init(repeating: 6, count: 0)
  var sesacFace: Int = 0
  var backgroundImage: Int = 0
  var searchable: Bool = false
  var ageMin: Int = 18
  var ageMax: Int = 65
}

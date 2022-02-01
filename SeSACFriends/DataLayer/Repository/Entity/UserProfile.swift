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
}

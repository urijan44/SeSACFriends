//
//  UserStorage.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/21.
//

import Foundation

public protocol UserStorage {
  var idToken: String { get set }
  var nickname: String { get set }
  var birthday: Date { get set }
  var email: String { get set }
  var gender: Int { get set }
  var phoneNumber: String { get set }
  var fcmToken: String { get set }
  var hobby: String { get set }
  var comment: [String] { get set }
  var reputation: [Int] { get set }
  var sesacFace: Int { get set }
  var backgroundImage: Int { get set }
  var searchable: Bool { get set }
  var ageMin: Int { get set }
  var ageMax: Int { get set }
}

//
//  UserSession.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import Foundation

final class UserSession {
  static let userDefault = UserDefaults.standard
  static let preReceiveVerifId = "preReceiveVerifId"
  class func savePreReceiveVerifId(_ id: String?) {
    userDefault.set(id, forKey: preReceiveVerifId)
  }

  class func loadPreReceiveVerifId() -> String? {
    userDefault.string(forKey: preReceiveVerifId)
  }

}

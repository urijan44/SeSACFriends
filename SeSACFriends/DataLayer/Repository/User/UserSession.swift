//
//  UserSession.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import Foundation

final class UserSession {

  static let shared = UserSession()

  var userProfile: UserProfile {
    didSet {
      save()
    }
  }
  private var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  private lazy var userProfileURL = url.appendingPathComponent("userProfile.json")

  static let userDefault = UserDefaults.standard
  static let preReceiveVerifId = "preReceiveVerifId"
  static func savePreReceiveVerifId(_ id: String?) {
    userDefault.set(id, forKey: preReceiveVerifId)
  }

  static func loadPreReceiveVerifId() -> String? {
    userDefault.string(forKey: preReceiveVerifId)
  }

  private init() {
    userProfile = UserProfile(nickname: "", birthday: Date(), email: "", gender: -1)
    load()
  }

  func saveNickname(nickname text: String) {
    userProfile.nickname = text
  }

  func loadNickname() -> String {
    userProfile.nickname
  }

  func saveBirthDay(birthday date: Date) {
    userProfile.birthday = date
  }

  func loadBirthDay() -> Date {
    userProfile.birthday
  }

  func saveEmail(email: String) {
    userProfile.email = email
  }

  func loadEmail() -> String {
    userProfile.email
  }

  func saveGender(gender: Int) {
    userProfile.gender = gender
  }

  func loadGender() -> Int {
    userProfile.gender
  }

  private func save() {
    guard let data = try? JSONEncoder().encode(userProfile) else { return }
    try? data.write(to: userProfileURL, options: .atomic)
    //save error?
  }

  private func load() {
    do {
      let data = try Data(contentsOf: url)
      let decoded = try JSONDecoder().decode(UserProfile.self, from: data)
      self.userProfile = decoded
    } catch {
      self.userProfile = UserProfile(nickname: "", birthday: Date(), email: "", gender: -1)
    }
  }
}

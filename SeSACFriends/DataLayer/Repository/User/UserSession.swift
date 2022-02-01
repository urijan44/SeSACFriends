//
//  UserSession.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import Foundation

final class UserSession {

  static let shared = UserSession()

  var userProfile: UserProfile

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
    userProfile = UserProfile()
    userProfile = load()
  }

  func savePhoneNumber(phoneNumber: String) {

    var convert = phoneNumber
    if !convert.hasPrefix("+82") {
      convert = convert.replacingOccurrences(of: "01", with: "+821")
    }
    userProfile.phoneNumber = convert
    save()
  }

  func loadPhoneNumber() -> String? {
    userProfile.phoneNumber
  }

  func saveNickname(nickname text: String) {
    userProfile.nickname = text
    save()
  }

  func loadNickname() -> String? {
    userProfile.nickname
  }

  func saveBirthDay(birthday date: Date) {
    userProfile.birthday = date
    save()
  }

  func loadBirthDay() -> Date? {
    userProfile.birthday
  }

  func saveEmail(email: String) {
    userProfile.email = email
    save()
  }

  func loadEmail() -> String? {
    userProfile.email
  }

  func saveGender(gender: Int) {
    userProfile.gender = gender
    save()
  }

  func loadGender() -> Int? {
    userProfile.gender
  }

  func saveIdToken(idToken: String) {
    userProfile.idToken = idToken
    save()
  }

  func loadIdToken() -> String? {
    userProfile.idToken
  }

  func saveFCMToken(fcmToken: String) {
    userProfile.fcmToken = fcmToken
    save()
  }

  func loadFCMToken() -> String? {
    userProfile.fcmToken
  }

  func signIn(signInUserDTO: SignInRemoteUserDTO) {
    userProfile.phoneNumber = signInUserDTO.phoneNumber
    userProfile.fcmToken = signInUserDTO.fcMtoken
  }

  func removeUserSession() {
    userProfile = UserProfile()
    save()
  }

  func signUpBody() -> Data {
    var body = RequestBody()
    body.append(contentsOf: [
      .init(key: "phoneNumber", value: userProfile.phoneNumber ?? ""),
      .init(key: "FCMtoken", value: userProfile.fcmToken ?? ""),
      .init(key: "nick", value: userProfile.nickname ?? ""),
      .init(key: "birth", value: userProfile.birthday?.birthday ?? ""),
      .init(key: "email", value: userProfile.email ?? ""),
      .init(key: "gender", value: userProfile.gender?.description ?? "")
    ])

    return body.convertData()
  }

  private func save() {
    guard let data = try? JSONEncoder().encode(userProfile) else { return }
    try? data.write(to: userProfileURL, options: .atomic)
    //save error?
  }

  private func load() -> UserProfile {
    do {
      let data = try Data(contentsOf: userProfileURL)
      let decoded = try JSONDecoder().decode(UserProfile.self, from: data)
      return decoded
    } catch {
      return UserProfile()
    }
  }
}

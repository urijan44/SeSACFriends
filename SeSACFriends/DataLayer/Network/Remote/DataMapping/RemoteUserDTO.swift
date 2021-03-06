//
//  RemoteUserDTO.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/01.
//

import Foundation

struct SignInRemoteUserDTO: Codable {
  let id: String
  let v: Int
  let uid, phoneNumber, email, fcMtoken: String
  let nick, birth: String
  let gender: Int
  let hobby: String
  let comment: [String]
  let reputation: [Int]
  let sesac: Int
  let sesacCollection: [Int]
  let background: Int
  let backgroundCollection: [Int]
  let purchaseToken, transactionID, reviewedBefore: [String]
  let reportedNum: Int
  let reportedUser: [String]
  let dodgepenalty, dodgeNum, ageMin, ageMax: Int
  let searchable: Int
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case v = "__v"
    case uid, phoneNumber, email
    case fcMtoken = "FCMtoken"
    case nick, birth, gender, hobby, comment, reputation, sesac, sesacCollection, background, backgroundCollection, purchaseToken
    case transactionID = "transactionId"
    case reviewedBefore, reportedNum, reportedUser, dodgepenalty, dodgeNum, ageMin, ageMax, searchable, createdAt
  }
}

extension SignInRemoteUserDTO {
  func toDomain() -> UserProfile {
    UserProfile(id: id,
                nickname: nick,
                birthday: birth.birthday,
                gender: gender,
                phoneNumber: phoneNumber,
                fcmToken: fcMtoken,
                hobby: hobby,
                comment: comment,
                reputation: reputation,
                sesacFace: sesac,
                backgroundImage: background,
                searchable: searchable == 1,
                ageMin: ageMin,
                ageMax: ageMax)
  }
}

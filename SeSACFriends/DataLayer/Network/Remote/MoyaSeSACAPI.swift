//
//  MoyaSeSACAPI.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/22.
//

import Foundation
import Moya

enum SeSACAPI {
  case updateMyPage(_ user: UserProfile)
  case withdraw(_ user: UserProfile)
}

extension SeSACAPI: TargetType {
  var baseURL: URL {
    URL(string: "http://test.monocoding.com:35484")!
  }

  var path: String {
    switch self {
      case .updateMyPage(_):
        return "/user/update/mypage"
      case .withdraw(_):
        return "/user/withdraw"
    }
  }

  var method: Moya.Method {
    switch self {
      case .updateMyPage(_):
        return Moya.Method.post
      case .withdraw(_):
        return Moya.Method.post
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    switch self {
      case .updateMyPage(let user):
        return .requestParameters(parameters: user.updateMyPage(), encoding: URLEncoding.httpBody)
      case .withdraw(_):
        return .requestPlain
    }
  }

  var headers: [String: String]? {
    switch self {
      case .updateMyPage(let user), .withdraw(let user):
        return [
          "idtoken": "\(user.idToken ?? "")",
          "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
  }

  var validationType: ValidationType {
    return .successCodes
  }
}

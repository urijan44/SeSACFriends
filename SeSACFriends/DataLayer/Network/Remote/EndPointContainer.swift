//
//  EndPointContainer.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/02.
//

import Foundation

final class EndPointContainer {
  let domain: URL

  private enum EndPoint: String {
    case user
    case withdraw
    case updateFCMToken = "update_fcm_token"
    case updateMyPage = "update/mypage"
  }

  init(domain: String) {
    guard let domain = URL(string: domain) else { fatalError("url convert error") }
    self.domain = domain
  }

  func signUpURL() -> URL {
    domain.appendingPathComponent(EndPoint.user.rawValue)
  }

  func signInURL() -> URL {
    signUpURL()
  }

  func withdrawURL() -> URL {
    signInURL().appendingPathComponent(EndPoint.withdraw.rawValue)
  }

  func updateFCMTokenURL() -> URL {
    domain
      .appendingPathComponent(EndPoint.user.rawValue)
      .appendingPathComponent(EndPoint.updateFCMToken.rawValue)
  }

  func updateMyPageURL() -> URL {
    signInURL().appendingPathComponent(EndPoint.updateMyPage.rawValue)
  }
}

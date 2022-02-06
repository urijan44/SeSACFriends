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
}

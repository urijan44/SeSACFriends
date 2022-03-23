//
//  APIError.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/16.
//

import Foundation
enum APIError: Error {
  case unknown
  case unregistered
  case tokenError
  case alreadyRegistered
  case cannotUseNickname
  case serverError
  case clientError
  case alreadyWithdraw
  case notModified
}

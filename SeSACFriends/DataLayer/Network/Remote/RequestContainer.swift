//
//  RequestContainer.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/02.
//

import Foundation

final class RequestContainer {

  private enum HTTPMethod: String {
    case GET
    case POST
    case PUT
  }

  private enum Header: String {
    case application = "application/x-www-form-urlencoded"
  }

  private enum HeaderField: String {
    case contentType = "Content-Type"
    case idToken = "idtoken"
  }

  private func defaultRequest(url: URL, method: HTTPMethod, idToken: String) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.addValue(Header.application.rawValue, forHTTPHeaderField: HeaderField.contentType.rawValue)
    request.addValue(idToken, forHTTPHeaderField: HeaderField.idToken.rawValue)
    return request
  }

  func signInRequest(url: URL, idToken: String) -> URLRequest {
    defaultRequest(url: url, method: .GET, idToken: idToken)
  }

  func signUpRequest(url: URL, idToken: String, requestBody: Data) -> URLRequest {
    var request = defaultRequest(url: url, method: .POST, idToken: idToken)
    request.httpBody = requestBody
    return request
  }

  func withdrawRequst(url: URL, idToken: String) -> URLRequest {
    defaultRequest(url: url, method: .POST, idToken: idToken)
  }

  func updateFCMTokenRequest(url: URL, idToken: String, requestBody: Data) -> URLRequest {
    var request = defaultRequest(url: url, method: .PUT, idToken: idToken)
    request.httpBody = requestBody
    return request
  }
}

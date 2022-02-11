//
//  SeSACRemoteAPI.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/01.
//

import Foundation

final class SeSACRemoteAPI {

  enum APIError: Error {
    case unknown
    case unregistered
    case tokenError
    case alreadyRegistered
    case cannotUseNickname
    case serverError
    case clientError
    case alreadyWithdraw
  }

  private lazy var endPoint = EndPointContainer(domain: domain)
  private lazy var requestContainer = RequestContainer()

  private let domain = "http://test.monocoding.com:35484"
  private let session = URLSession.shared

  func signIn(idToken: String, completion: @escaping (Result<Void, APIError>) -> Void) {

    let request = requestContainer.signInRequest(
      url: endPoint.signInURL(),
      idToken: idToken
    )
    task(request: request, requestType: .signIn) { result in
      completion(result)
    }
//    updateFCMtoken(idToken: idToken) { [unowned self] updateResult in
//      switch updateResult {
//        case .success:
//        case .failure(let error):
//          completion(.failure(error))
//      }
//    }
  }

  func signUp(idToken: String, completion: @escaping (Result<Void, APIError>) -> Void) {

    let request = requestContainer.signUpRequest(
      url: endPoint.signUpURL(),
      idToken: idToken,
      requestBody: UserSession.shared.signUpBody())

    self.task(request: request, requestType: .signUp) { result in
      completion(result)
    }
  }

  func withdraw(idToken: String, completion: @escaping (Result<Void, APIError>) -> Void) {
    let request = requestContainer.withdrawRequst(
      url: endPoint.withdrawURL(),
      idToken: idToken)

    self.task(request: request, requestType: .withdraw) { result in
      completion(result)
    }
  }

  func updateFCMtoken(idToken: String, completion: @escaping (Result<Void, APIError>) -> Void) {
    let request = requestContainer
      .updateFCMTokenRequest(
        url: endPoint.updateFCMTokenURL(),
        idToken: idToken,
        requestBody: UserSession.shared.updateFMCBody())

    self.task(request: request, requestType: .updateFCMToken) { result in
      completion(result)
    }
  }

  private func task(request: URLRequest, requestType: RequestType, completion: @escaping (Result<Void, APIError>) -> Void) {
    let task = session.dataTask(with: request) { data, response, error in
      DispatchQueue.main.async { 
        if error != nil {
          completion(.failure(APIError.unknown))
          return
        }

        guard let response = response as? HTTPURLResponse else {
          completion(.failure(APIError.unknown))
          return
        }

        if let responseResult = self.reponseCodeHandling(statusCode: response.statusCode, requestType: requestType) {
          completion(.failure(responseResult))
          return
        }

        if let data = data {
          do {
            try self.dataHandling(data: data, requestType: requestType)
            UserSession.shared.sessionState = .login
            completion(.success(()))
          } catch {
            //invalid data
            completion(.failure(APIError.unknown))
          }
        } else {
          completion(.failure(APIError.unknown))
          //no data
        }
      }
    }

    task.resume()
  }

  private func dataHandling(data: Data, requestType: RequestType) throws {
    switch requestType {
      case .signIn:
        do {
          let payload = try JSONDecoder().decode(SignInRemoteUserDTO.self, from: data)
          UserSession.shared.signIn(signInUserDTO: payload)
        } catch {
          throw APIError.unknown
        }
      case .signUp:
        let _ = "OK"
      case .withdraw:
        let _ = "delete"
      case .updateFCMToken:
        let _ = "OK"
    }
  }

  enum RequestType {
    case signIn
    case signUp
    case withdraw
    case updateFCMToken
  }

  private func reponseCodeHandling(statusCode: Int, requestType: RequestType) -> APIError? {

    switch requestType {
      case .signIn:
        return signInErrorContainer(code: statusCode)
      case .signUp:
        return signUpErrorContainer(code: statusCode)
      case .withdraw:
        return withdrawErrorContainer(code: statusCode)
      case .updateFCMToken:
        return updateFCMTokenErrorContainer(code: statusCode)
    }
  }

  private func signInErrorContainer(code: Int) -> APIError? {
    if code == 200 {
      return nil
    } else {
      switch code {
        case 201:
          return .unregistered
        case 401:
          return .tokenError
        case 500:
          return .serverError
        case 501:
          return .clientError
        default:
          return .unknown
      }
    }
  }

  private func signUpErrorContainer(code: Int) -> APIError? {
    if code == 200 {
      return nil
    } else {
      switch code {
        case 201:
          return .alreadyRegistered
        case 202:
          return .cannotUseNickname
        case 401:
          return .tokenError
        case 500:
          return .serverError
        case 501:
          return .clientError
        default:
          return .unknown
      }
    }
  }

  private func withdrawErrorContainer(code: Int) -> APIError? {
    if code == 200 {
      return nil
    } else {
      switch code {
        case 401:
          return .tokenError
        case 406:
          return .alreadyWithdraw
        case 500:
          return .serverError
        default:
          return .unknown
      }
    }
  }

  private func updateFCMTokenErrorContainer(code: Int) -> APIError? {
    switch code {
      case 200:
        return nil
      case 401:
        return .tokenError
      case 406:
        return .unregistered
      case 500:
        return .serverError
      case 501:
        return .clientError
      default:
        return .unknown
    }
  }
}

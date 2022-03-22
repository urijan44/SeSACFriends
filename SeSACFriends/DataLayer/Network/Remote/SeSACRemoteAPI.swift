//
//  SeSACRemoteAPI.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/01.
//

import Foundation
import Moya

final class SeSACRemoteAPI {

  private lazy var endPoint = EndPointContainer(domain: domain)
  private lazy var requestContainer = RequestContainer()

  private let domain = "http://test.monocoding.com:35484"
  private let session = URLSession.shared
  private let user = UserSession.shared
  private let provider = MoyaProvider<SeSACAPI>(plugins: [CachePolicyPlugin()])

  func signIn(idToken: String, completion: @escaping (Result<UserProfile, APIError>) -> Void) {

    let request = requestContainer.signInRequest(
      url: endPoint.signInURL(),
      idToken: idToken
    )

    task(request: request, requestType: .signIn) { result in
      switch result {
        case .success(let userSession):
          completion(.success(userSession.toDomain()))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  func signIn(userProfile: UserProfile, completion: @escaping (Result<UserProfile, APIError>) -> Void) {
    var copyUserProfile = userProfile
    copyUserProfile.idToken = user.loadIdToken() ?? ""
    provider.request(.signIn(copyUserProfile)) { result in
      switch result {
        case .success(let response):
          if let userDTO = try? self.dataHandling(data: response.data, requestType: .signIn) {
            UserSession.shared.sessionState = .login
            completion(.success(userDTO.toDomain()))
          }
        case .failure(let error):
          let serviceError = self.reponseCodeHandling(
            statusCode: error.response?.statusCode ?? 501,
            requestType: .signIn)!

          completion(.failure(serviceError))
      }
    }
  }

  func signUp(idToken: String, completion: @escaping (Result<SignInRemoteUserDTO, APIError>) -> Void) {

    let request = requestContainer.signUpRequest(
      url: endPoint.signUpURL(),
      idToken: idToken,
      requestBody: UserSession.shared.signUpBody())

    self.task(request: request, requestType: .signUp) { result in
      completion(result)
    }
  }

  func withdraw(idToken: String, completion: @escaping (Result<SignInRemoteUserDTO, APIError>) -> Void) {
    let request = requestContainer.withdrawRequst(
      url: endPoint.withdrawURL(),
      idToken: idToken)

    self.task(request: request, requestType: .withdraw) { result in
      completion(result)
    }
  }

  func updateFCMtoken(idToken: String, completion: @escaping (Result<SignInRemoteUserDTO, APIError>) -> Void) {
    let request = requestContainer
      .updateFCMTokenRequest(
        url: endPoint.updateFCMTokenURL(),
        idToken: idToken,
        requestBody: user.updateFMCBody())

    self.task(request: request, requestType: .updateFCMToken) { result in
      completion(result)
    }
  }

  func updateMyPage(idToken: String, completion: @escaping (Result<Void, APIError>) -> Void) {
    let request = requestContainer
      .updateMyPageRequest(
        url: endPoint.updateMyPageURL(),
        idToken: idToken,
        requestBody: user.updateMyPage())

    self.task(request: request, requestType: .updateMypage) { result in
      switch result {
        case .success:
          completion(.success(()))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  func updateMyPage(userProfile: UserProfile, completion: @escaping (Result<Void, APIError>) -> Void) {
    var copyUserProfile = userProfile
    copyUserProfile.idToken = user.loadIdToken() ?? ""
    provider.request(.updateMyPage(copyUserProfile)) { result in
      switch result {
        case .success:
          completion(.success(()))
        case .failure(let error):
          let serviceError = self.reponseCodeHandling(
            statusCode: error.response?.statusCode ?? 501,
            requestType: .updateMypage)!

          completion(.failure(serviceError))
      }
    }
  }

  func withdraw(userProfile: UserProfile, completion: @escaping (Result<Void, APIError>) -> Void) {
    provider.request(.withdraw(user.userProfile)) { result in
      switch result {
        case .success:
          completion(.success(()))
        case .failure(let error):
          let serviceError = self.reponseCodeHandling(
            statusCode: error.response?.statusCode ?? 501,
            requestType: .withdraw)!
          completion(.failure(serviceError))
      }
    }
  }

  private func task(request: URLRequest, requestType: RequestType, completion: @escaping (Result<SignInRemoteUserDTO, APIError>) -> Void) {
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

          print(response)
          do {
            let userDTO = try self.dataHandling(data: data, requestType: requestType)
            UserSession.shared.sessionState = .login
            completion(.success((userDTO!)))
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

  @discardableResult
  private func dataHandling(data: Data, requestType: RequestType) throws -> SignInRemoteUserDTO? {
    switch requestType {
      case .signIn:
        do {
          let payload = try JSONDecoder().decode(SignInRemoteUserDTO.self, from: data)
          UserSession.shared.signIn(signInUserDTO: payload)
          return payload
        } catch {
          throw APIError.unknown
        }
      case .signUp:
        do {
          let payload = try JSONDecoder().decode(SignInRemoteUserDTO.self, from: data)
          return payload
//          UserSession.shared.signIn(signInUserDTO: payload)
        } catch {
          throw APIError.unknown
        }
      case .withdraw:
        do {
          let payload = try JSONDecoder().decode(SignInRemoteUserDTO.self, from: data)
          return payload
//          UserSession.shared.signIn(signInUserDTO: payload)
        } catch {
          throw APIError.unknown
        }
      case .updateFCMToken:
        do {
          let payload = try JSONDecoder().decode(SignInRemoteUserDTO.self, from: data)
          return payload
//          UserSession.shared.signIn(signInUserDTO: payload)
        } catch {
          throw APIError.unknown
        }
      case .updateMypage:
        return nil
    }
  }

  enum RequestType {
    case signIn
    case signUp
    case withdraw
    case updateFCMToken
    case updateMypage
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
      case .updateMypage:
        return updateMyPageErrorContainer(code: statusCode)
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

  private func updateMyPageErrorContainer(code: Int) -> APIError? {
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

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

  func task(request: URLRequest, requestType: RequestType, completion: @escaping (Result<Void, APIError>) -> Void) {
    let task = session.dataTask(with: request) { [weak self] data, response, error in
      DispatchQueue.main.async {
        if error != nil {
          completion(.failure(APIError.unknown))
          return
        }

        guard let response = response as? HTTPURLResponse else {
          completion(.failure(APIError.unknown))
          return
        }

        self?.reponseCodeHandling(statusCode: response.statusCode, requestType: requestType) { result in
          switch result {
            case .success():
              return
            case .failure:
              completion(result)
              return
          }
        }
        if let data = data {
          do {
            try self?.dataHandling(data: data, requestType: .signIn)
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
        do {
          let payload = try JSONDecoder().decode(SignInRemoteUserDTO.self, from: data)
          UserSession.shared.signIn(signInUserDTO: payload)
        } catch {
          throw APIError.unknown
        }
    }
  }

  enum RequestType {
    case signIn
    case signUp
  }

  private func reponseCodeHandling(statusCode: Int, requestType: RequestType, completion: @escaping (Result<Void, APIError>) -> Void) {

    switch requestType {
      case .signIn:
        signInErrorContainer(code: statusCode) { result in
          completion(result)
        }
      case .signUp:
        signUpErrorContainer(code: statusCode) { result in
          completion(result)
        }
    }
  }

  private func signInErrorContainer(code: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
    if code == 200 {
      completion(.success(()))
    } else {
      switch code {
        case 201:
          completion(.failure(.unregistered))
        case 401:
          completion(.failure(.tokenError))
        case 500:
          completion(.failure(.serverError))
        case 501:
          completion(.failure(.clientError))
        default:
          completion(.failure(.unknown))
      }
    }
  }

  private func signUpErrorContainer(code: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
    if code == 200 {
      completion(.success(()))
    } else {
      switch code {
        case 201:
          completion(.failure(.alreadyRegistered))
        case 202:
          completion(.failure(.cannotUseNickname))
        case 401:
          completion(.failure(.tokenError))
        case 500:
          completion(.failure(.serverError))
        case 501:
          completion(.failure(.clientError))
        default:
          completion(.failure(.unknown))
      }
    }
  }
}

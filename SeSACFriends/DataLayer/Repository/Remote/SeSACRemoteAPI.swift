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
  }

  private lazy var endPoint = EndPointContainer(domain: domain)
  private lazy var requestContainer = RequestContainer()

  private let domain = "http://test.monocoding.com:35484"
  private let session = URLSession.shared

  func signIn(idToken: String, completion: @escaping (Result<Void, APIError>) -> Void) {

    let request = requestContainer.signInRequest(url: endPoint.signInURL(), idToken: idToken)
    session.dataTask(with: request) { data, response, error in
      if error != nil {
        completion(.failure(APIError.unknown))
        return
      }

      guard let response = response as? HTTPURLResponse else {
        completion(.failure(APIError.unknown))
        return
      }

      guard 200..<300 ~= response.statusCode || 201 == response.statusCode else {
        switch response.statusCode {
          case 201:
            completion(.failure(APIError.unregistered))
          case 401:
            completion(.failure(APIError.tokenError))
          case 500:
            completion(.failure(APIError.unknown))
          case 501:
            completion(.failure(APIError.unknown))
          default:
            completion(.failure(APIError.unknown))
        }
        return
      }

      if let data = data {
        do {
          let payload = try JSONDecoder().decode(SignInRemoteUserDTO.self, from: data)
          UserSession.shared.signIn(signInUserDTO: payload)
          completion(.success(()))
        } catch {
          //invalid data
          completion(.failure(APIError.unknown))
        }
      } else {
        completion(.failure(APIError.unknown))
        //no data
      }
    }.resume()
  }

  func signUp(idToken: String, completion: @escaping (Result<Void, APIError>) -> Void) {

    let request = requestContainer.signUpRequest(
      url: endPoint.signUpURL(),
      idToken: idToken,
      requestBody: UserSession.shared.signUpBody())

    session.dataTask(with: request) { data, response, error in

    }.resume()

  }
}

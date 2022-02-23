//
//  DefaultServerRepository.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/16.
//

import Foundation

final class DefaultServerRepository {
  private let remoteAPIService: SeSACRemoteAPI
  private let cache = UserSession.shared

  //SesACRemoteAPI Protocol 진행할 것
  init(remoteAPIService: SeSACRemoteAPI) {
    self.remoteAPIService = remoteAPIService
  }
}

extension DefaultServerRepository: ServerRepository {
  public func fetchUserProfile(cached: @escaping (UserProfile) -> Void,
                               completion: @escaping (Result<UserProfile, APIError>) -> Void) {

    let idToken = cache.loadIdToken() ?? ""

    remoteAPIService.signIn(idToken: idToken) { [unowned self] result in
      switch result {
        case .success(let profile):
          cache.saveUserProfile(userProfile: profile)
          completion(.success(profile))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  func updateMyPage(completion: @escaping (Result<Void, APIError>) -> Void) {
    remoteAPIService.updateMyPage { result in
      completion(result)
    }
  }

  func withdraw(completion: @escaping (Result<Void, APIError>) -> Void) {
    
  }
}

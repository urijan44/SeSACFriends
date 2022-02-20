//
//  ProfileUseCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/14.
//

import Foundation

protocol ProfileUseCase {
  func requestSignIn(completion: @escaping (Result<UserProfile, APIError>) -> Void)
  func execute()
}

final class DefaultProfileUseCase: ProfileUseCase {

  private let serverRepository: ServerRepository

  init(serverRepository: ServerRepository) {
    self.serverRepository = serverRepository
  }

  func requestSignIn(completion: @escaping (Result<UserProfile, APIError>) -> Void) {
    serverRepository.fetchUserProfile { _ in

    } completion: { result in
      switch result {
        case .success(let profile):
          completion(.success(profile))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  func execute() {

  }
}

struct ProfileUseCaseRequest {

  enum `Type` {
    case save
    case withdraw
  }

  let user: String
  let type: Type
}

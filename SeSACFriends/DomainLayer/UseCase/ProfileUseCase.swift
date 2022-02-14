//
//  ProfileUseCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/14.
//

import Foundation

protocol ProfileUseCase {
  func execute()
}

final class DefaultProfileUseCase: ProfileUseCase {
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

//
//  ServerRepository.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/15.
//

import Foundation

protocol ServerRepository {
  func fetchUserProfile(cached: @escaping (UserProfile) -> Void,
                        completion: @escaping (Result<UserProfile, APIError>) -> Void)
}

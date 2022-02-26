//
//  SignInUseCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/01.
//

import Foundation
import RxSwift

final class SignInUseCase {

  func signIn(idToken: String) -> Single<Void> {
    return Single<Void>
      .create { single in
      let remote = SeSACRemoteAPI()
      remote.signIn(idToken: idToken) { result in
        switch result {
          case .success:
            single(.success(()))
          case .failure(let error):
            single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }

  func errorHandling(_ error: Error) -> APIError {
    guard let error = error as? APIError else { return .unknown }
    return error
  }
}

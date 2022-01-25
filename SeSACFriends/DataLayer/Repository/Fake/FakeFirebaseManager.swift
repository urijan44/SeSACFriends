//
//  FakeFirebaseManager.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import Foundation

final class FakePhoneAuthProvider {
  class func provider() -> FakePhoneAuthProvider {
    return FakePhoneAuthProvider()
  }

  func verifyPhoneNumber(_ phone: String, uiDelegate: Bool?, error: Bool = true, completion: @escaping (String?, Error?) -> Void) {
    let testId = "123456"
    let testError = NSError(domain: "FIRAuthErrorDomain", code: 17042, userInfo: ["NSLocalizedDescription=Invalid": "ERROR_INVALID_PHONE_NUMBER"])

    if error {
      completion(nil, testError)
    } else {
      completion(testId, nil)
    }
  }
}

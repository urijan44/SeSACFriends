//
//  FakeFirebaseManager.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import Foundation

final class FakePhoneAuthCredential {
  let userInput: String
  let serverId: String

  init(userInput: String, serverId: String) {
    self.userInput = userInput
    self.serverId = serverId
  }

  var check: Bool {
    self.userInput == self.serverId
  }
}

final class FakePhoneAuthProvider {
  class func provider() -> FakePhoneAuthProvider {
    return FakePhoneAuthProvider()
  }

  func verifyPhoneNumber(_ phone: String, uiDelegate: Bool?, error: Bool = false, completion: @escaping (String?, Error?) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      let testId = "123456"
      let testError = NSError(domain: "FIRAuthErrorDomain", code: 17010, userInfo: ["NSLocalizedDescription=Invalid": "ERROR_INVALID_PHONE_NUMBER"])

      if error {
        completion(nil, testError)
      } else {
        completion(testId, nil)
      }
    }
  }

  func credential(withVerificationID verificationID: String, verificationCode: String) -> FakePhoneAuthCredential {
    let credential = FakePhoneAuthCredential(userInput: verificationID, serverId: verificationCode)
    return credential
  }
}

final class FakeAuth {
  class func auth() -> FakeAuth {
    return FakeAuth()
  }

  func signIn(with credential: FakePhoneAuthCredential, completion: ((Int?, Error?) -> Void)? = nil) {
    let testError = NSError(domain: "뿌에에엑", code: 17044, userInfo: ["NSLocalizedDescription=Invalid": "ERROR_INVALID_PHONE_NUMBER"])

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      if credential.check {
        completion?(200, nil)
      } else {
        completion?(nil, testError)
      }
    }
  }
}

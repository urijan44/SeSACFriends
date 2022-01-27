//
//  FirebaseErrorHandling.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import Foundation

final class FirebaseErrorHandling {
  class func PhoneAuthHandling(_ error: Error) -> Int {
    let nsError = error as NSError
    return nsError.code
  }
}

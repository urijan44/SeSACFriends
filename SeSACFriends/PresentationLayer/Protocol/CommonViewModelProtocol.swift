//
//  CommonViewModelProtocol.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/27.
//

import Foundation

protocol CommonViewModel {
  associatedtype Input
  associatedtype Output
  func transform(_ input: Input) -> Output
}

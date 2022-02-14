//
//  Date+Extension.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/02.
//

import Foundation

extension Date {
  var birthday: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return formatter.string(from: self)
  }
}

extension String {
  var birthday: Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return formatter.date(from: self)
  }
}

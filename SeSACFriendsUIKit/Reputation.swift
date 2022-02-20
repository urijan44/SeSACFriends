//
//  Reputation.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/20.
//

import Foundation

public enum Reputation: String, CaseIterable {
  case goodManner = "좋은 매너"
  case onTime = "정확한 시간 약속"
  case quickResponse = "빠른 응답"
  case kind = "친절한 성격"
  case hobbyLevel = "능숙한 취미 실력"
  case goodExperience = "유익한 시간"

  static func mockReputation() -> [ConvertedTitle] {
    var convertedTitles: [ConvertedTitle] = []
    Reputation.allCases.forEach { reputation in
      let title = ConvertedTitle(title: reputation.rawValue, count: 0)
      convertedTitles.append(title)
    }
    return convertedTitles
  }
}

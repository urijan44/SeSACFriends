//
//  ProfileViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/11.
//

import Foundation
import SwiftUI
import SeSACFriendsUIKit

final class ProfileViewModel: ObservableObject {

  @Published var title: [ConvertedTitle] =
  [
    .init(title: "좋은 매너"),
    .init(title: "정확한 시간 약속"),
    .init(title: "빠른 응답"),
    .init(title: "친절한 성격"),
    .init(title: "능숙한 취미 실력"),
    .init(title: "유익한 시간"),
  ]

  @Published var lowerAge: Int = 18
  @Published var higherAge: Int = 65
}

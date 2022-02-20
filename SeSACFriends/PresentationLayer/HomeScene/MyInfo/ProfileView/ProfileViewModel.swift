//
//  ProfileViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/11.
//

import Foundation
import SwiftUI
import SeSACFriendsUIKit
import RxSwift
import RxRelay

final class ProfileViewModel: ObservableObject {

  private let useCase: ProfileUseCase
  weak var coordinator: Coordinator?
  private let bag = DisposeBag()

  @Published var userProfile = UserProfile() {
    didSet {
      nickname = userProfile.nickname
      reputationConvert()
    }
  }

  @Published var showToast: (state: Bool, message: String) = (false, "")

  @Published var nickname = ""
  @Published var hobbies: [String] = []
  @Published var reputation: [ConvertedTitle] = .init(repeating: .init(), count: 6)

  init(useCase: ProfileUseCase, coordinator: Coordinator?) {
    self.useCase = useCase
    self.coordinator = coordinator
  }

  func requestWithdraw() {

  }

  func loadUserProfile() {
    useCase.requestSignIn { [weak self] result in
      switch result {
        case .success(let profile):
          self?.userProfile = profile
        case .failure(let error):
          self?.showToast = (true, error.localizedDescription)
      }
    }
  }

  func reputationConvert() {
    var reputation: [ConvertedTitle] = []
    for (count, title) in zip(userProfile.reputation, Reputation.allCases) {
      let convertedTitle = ConvertedTitle(title: title.rawValue, count: count)
      reputation.append(convertedTitle)
    }
    self.reputation = reputation
  }
}

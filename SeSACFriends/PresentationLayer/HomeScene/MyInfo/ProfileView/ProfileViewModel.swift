//
//  ProfileViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/11.
//

import Foundation
import SwiftUI
import SeSACFriendsUIKit

extension ProfileView {
  final class ProfileViewModel: ObservableObject {

    deinit {
      print("ProfileViewmodel deinit")
    }

    private let useCase: ProfileUseCase
    weak var coordinator: Coordinator?

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
    @Published var isProgressing: Bool = false
    @Published var dismissSignal: Bool = false
    @Published var showWithdrawAlert = false
    @Published var withdrawSuccessSignal = false

    init(useCase: ProfileUseCase, coordinator: Coordinator?) {
      self.useCase = useCase
      self.coordinator = coordinator
    }

    func requestWithdraw() {
      isProgressing = true
      useCase.withdraw { [weak self] result in
        switch result {
          case .success(()):
            (self?.coordinator as? AppDelegateCoordinator)?.startOnBoardingCoordinator()
            self?.withdrawSuccessSignal = true
          case .failure(let error):
            self?.showToast = (true, error.localizedDescription)
            self?.isProgressing = false
        }
      }
    }

    func update() {
      isProgressing = true

      useCase.update(userProfile: userProfile) { [weak self] result in
        switch result {
          case .success(()):
            self?.dismissSignal = true
            self?.isProgressing = false
          case .failure(let error):
            self?.showToast = (true, error.localizedDescription)
            self?.isProgressing = false
        }
      }
    }

    func loadUserProfile() {
      useCase.requestSignIn { [weak self] result in
        switch result {
          case .success(let profile):
            self?.userProfile = profile
          case .failure:
            self?.showToast = (true, "정보를 가져오는데 실패했습니다.")
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

}

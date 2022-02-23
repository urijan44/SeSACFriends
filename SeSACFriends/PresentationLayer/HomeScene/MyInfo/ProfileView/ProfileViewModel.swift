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

extension ProfileView {
  final class ProfileViewModel: ObservableObject {

    deinit {
      print("ProfileViewmodel deinit")
    }

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
    @Published var isProgressing: Bool = false
    @Published var dismissSignal: Bool = false

    init(useCase: ProfileUseCase, coordinator: Coordinator?) {
      self.useCase = useCase
      self.coordinator = coordinator
    }

    func requestWithdraw() {

    }

    func update() {
      isProgressing = true

      useCase.update(userProfile: userProfile) { [unowned self] result in
        switch result {
          case .success(()):
            dismissSignal = true
            isProgressing = false
          case .failure(let error):
            showToast = (true, error.localizedDescription)
            isProgressing = false
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

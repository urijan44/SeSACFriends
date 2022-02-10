//
//  OnBoardingCoordinator.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import UIKit

final class OnBoardingCoordinator: Coordinator {
  let container = OnBoardingContainer()
  var children: [Coordinator] = []
  var router: Router

  enum Skip {
    case welcome
    case phoneAuth
    case signUp
  }

  lazy var skip: Skip = .welcome

  lazy var welcomeView = WelcomeViewController(viewModel: WelcomeViewModel(), delegate: self)
  lazy var phoneAuthView = container.makePhoneAuthView(delegate: self)
  lazy var validateCodeCheckView = container.makeValidateCodeCheckView(delegate: self)
  lazy var nicknameView = container.makeNicknameView(delegate: self)
  lazy var birthdayView = container.makeBirthdayView(delegate: self)
  lazy var emailView = container.makeEmailView(delegate: self)
  lazy var genderView = container.makeGenderView(delegate: self)

  init(router: Router) {
    self.router = router
  }

  func present(animated: Bool, onDismissed: (() -> Void)?) {
    switch skip {
    case .welcome:
      router.present(welcomeView, animated: true, onDismissed: onDismissed)
    case .phoneAuth:
      router.present(phoneAuthView, animated: true, onDismissed: onDismissed)
    case .signUp:
      router.present(nicknameView, animated: true, onDismissed: onDismissed)
    }
  }
}

extension OnBoardingCoordinator: WelcomeViewControllerDelegate {
  func startonBoardingButton() {
    (router as? OnBoardingNavigationRouter)?.changeRootPresent(from: welcomeView, phoneAuthView)
  }
}

extension OnBoardingCoordinator: PhoneAuthMainViewDelegate {
  func phoneAuthMainViewPushVerificationCodeView() {
    router.present(validateCodeCheckView, animated: true)
  }
}

extension OnBoardingCoordinator: ValidateCodeCheckViewDeledage {
  func validateCodeCheck() {
    router.present(nicknameView, animated: true)
  }

  func cancelValidateCodeCheck() {
    validateCodeCheckView.navigationController?.popViewController(animated: true)
  }

  func presentLogin() {
    dismiss(animated: false)
  }
}

extension OnBoardingCoordinator: NicknameRootViewDelegate {
  func nicknameCheck() {
    router.present(birthdayView, animated: true)
  }

  func cancelNicknameCheck() {
    nicknameView.navigationController?.popViewController(animated: true)
  }
}

extension OnBoardingCoordinator: BirthdayRootViewDelegate {
  func birthdayCheck() {
    router.present(emailView, animated: true)
  }

  func cancelBirthdayCheck() {
    birthdayView.navigationController?.popViewController(animated: true)
  }
}

extension OnBoardingCoordinator: EmailRootViewDelegate {
  func emailCheck() {
    router.present(genderView, animated: true)
  }

  func cancelEmailCheck() {
    emailView.navigationController?.popViewController(animated: true)
  }
}

extension OnBoardingCoordinator: GenderRootViewDelegate {
  func genderCheck() {
    dismiss(animated: false)
  }

  func cancelGenderCheck() {
    genderView.navigationController?.popViewController(animated: true)
  }

  func nicknameFailure() {
    nicknameView.rootView.viewModel.useCase.showToastMessage.onNext(ToastMessage.Nickname.init(.cantUseNickname, messageState: true))
    genderView.navigationController?.popToViewController(nicknameView, animated: true)
  }
}

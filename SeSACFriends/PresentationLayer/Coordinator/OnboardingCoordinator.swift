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
    var test = 4
    switch test {
      case -2:
        router.present(welcomeView, animated: true)
      case -1:
        router.present(phoneAuthView, animated: true)
      case 0:
        router.present(validateCodeCheckView, animated: true)
      case 1:
        router.present(nicknameView, animated: true)
      case 2:
        router.present(birthdayView, animated: true)
      case 3:
        router.present(emailView, animated: true)
      case 4:
        router.present(genderView, animated: true)
      default:
        fatalError("Unsupport view")
    }
  }
}

extension OnBoardingCoordinator: WelcomeViewControllerDelegate {
  func startonBoardingButton() {
    (router as? OnBoardingNavigationRouter)?.changeRootPresent(phoneAuthView, onDismissed: nil)
  }
}

extension OnBoardingCoordinator: PhoneAuthMainViewDelegate {
  func phoneAuthMainViewPushVerificationCodeView() {
    router.present(phoneAuthView, animated: true)
  }
}

extension OnBoardingCoordinator: ValidateCodeCheckViewDeledage {
  func validateCodeCheck() {
    router.present(nicknameView, animated: true)
  }

  func cancelValidateCodeCheck() {
    validateCodeCheckView.navigationController?.popViewController(animated: true)
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
    
  }

  func cancelGenderCheck() {
    genderView.navigationController?.popViewController(animated: true)
  }

  func nicknameFailure() {
    genderView.navigationController?.popToViewController(nicknameView, animated: true)
  }
}

//
//  OnBoardingCoordinator.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import UIKit

final class OnBoardingCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  lazy var welcomeView = WelcomeViewController(viewModel: WelcomeViewModel(), delegate: self)
  lazy var phoneAuthView = makePhoneAuthView()
  lazy var validateCodeCheckView = makeValidateCodeCheckView()
  lazy var nicknameView = makeNicknameView()
  lazy var birthdayView = makeBirthdayView()

  init(router: Router) {
    self.router = router
  }

  func present(animated: Bool, onDismissed: (() -> Void)?) {
    var test = 2
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
      default:
        fatalError("Unsupport view")
    }
  }

  private func makePhoneAuthView() -> PhoneAuthViewController {
    let viewModel = PhoneAuthViewModel(useCase: PhoneAuthUseCase())
    let rootView = PhoneAuthMainView(viewModel: viewModel, delegate: nil)
    let controller = PhoneAuthViewController(rootView: rootView)
    return controller
  }

  private func makeValidateCodeCheckView() -> ValidateCodeCheckViewController {
    let viewModel = ValidateCodeCheckViewModel(useCase: ValidateCodeUseCase())
    let rootView = ValidateCodeCheckView(viewModel: viewModel, delegate: self)
    let controller = ValidateCodeCheckViewController(rootView: rootView)
    return controller
  }

  private func makeNicknameView() -> NicknameViewController {
    let viewModel = NicknameViewModel(useCase: SignUpUseCase())
    let rootView = NicknameRootView(viewModel: viewModel, delegate: self)
    let controller = NicknameViewController(rootView: rootView)
    return controller
  }

  private func makeBirthdayView() -> BirthdayViewController {
    let viewModel = BirthdayViewModel(useCase: BirthdayUseCase())
    let rootView = BirthdayRootView(viewModel: viewModel, delegate: self)
    let controller = BirthdayViewController(rootView: rootView)
    return controller
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
//    router.dismiss(animated: true)
    validateCodeCheckView.navigationController?.popViewController(animated: true)
  }
}

extension OnBoardingCoordinator: NicknameRootViewDelegate {
  func nicknameCheck() {
    router.present(birthdayView, animated: true)
  }

  func cancelNicknameCheck() {
//    router.dismiss(animated: true)
    nicknameView.navigationController?.popViewController(animated: true)
  }
}

extension OnBoardingCoordinator: BirthdayRootViewDelegate {
  func birthdayCheck() {

  }

  func cancelBirthdayCheck() {
//    router.dismiss(animated: true)
    birthdayView.navigationController?.popViewController(animated: true)
  }
}

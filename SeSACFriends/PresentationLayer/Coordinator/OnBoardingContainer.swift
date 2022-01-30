//
//  OnBoardingContainer.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/31.
//

import Foundation

final class OnBoardingContainer {

  func makePhoneAuthView(delegate: PhoneAuthMainViewDelegate) -> PhoneAuthViewController {
    let viewModel = PhoneAuthViewModel(useCase: PhoneAuthUseCase())
    let rootView = PhoneAuthMainView(viewModel: viewModel, delegate: delegate)
    let controller = PhoneAuthViewController(rootView: rootView)
    return controller
  }

  func makeValidateCodeCheckView(delegate: ValidateCodeCheckViewDeledage) -> ValidateCodeCheckViewController {
    let viewModel = ValidateCodeCheckViewModel(useCase: ValidateCodeUseCase())
    let rootView = ValidateCodeCheckView(viewModel: viewModel, delegate: delegate)
    let controller = ValidateCodeCheckViewController(rootView: rootView)
    return controller
  }

  func makeNicknameView(delegate: NicknameRootViewDelegate) -> NicknameViewController {
    let viewModel = NicknameViewModel(useCase: SignUpUseCase())
    let rootView = NicknameRootView(viewModel: viewModel, delegate: delegate)
    let controller = NicknameViewController(rootView: rootView)
    return controller
  }

  func makeBirthdayView(delegate: BirthdayRootViewDelegate) -> BirthdayViewController {
    let viewModel = BirthdayViewModel(useCase: BirthdayUseCase())
    let rootView = BirthdayRootView(viewModel: viewModel, delegate: delegate)
    let controller = BirthdayViewController(rootView: rootView)
    return controller
  }

  func makeEmailView(delegate: EmailRootViewDelegate) -> EmailViewController {
    let viewModel = EmailViewModel(useCase: EmailUseCase())
    let rootView = EmailRootView(viewModel: viewModel, delegate: delegate)
    let controller = EmailViewController(rootView: rootView)
    return controller
  }

}

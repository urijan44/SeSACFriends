//
//  OnboardingCoordinator.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import UIKit
import RxSwift

final class AppDelegateCoordinator: Coordinator {
  var children: [Coordinator] = []
  let router: Router
  let bag = DisposeBag()
  var navigationController = UINavigationController()
  init(router: Router) {
    self.router = router
  }

  func present(animated: Bool, onDismissed: (() -> Void)?) {

    //어캐 처리하지...
    //계정 정보가 있으면 홈탭!
    if let idToken = UserSession.shared.loadIdToken() {
      let useCase = SignInUseCase()
      useCase.signIn(idToken: idToken)
        .subscribe(onSuccess: { [weak self] _ in

          self?.startHomeCoordinator()

      }, onFailure: { [weak self] error in

        switch useCase.errorHandling(error) {
          case .tokenError:
            self?.startOnBoardingCoordinator(skip: .phoneAuth)
          case .unregistered:
            UserSession.shared.removeUserSession()
            self?.startOnBoardingCoordinator(skip: .signUp)
          case .unknown:
            UserSession.shared.removeUserSession()
            self?.startOnBoardingCoordinator()
        }
        //계정 정보 없으면 -> 온보딩 코디
      }).disposed(by: bag)
    } else {
      startOnBoardingCoordinator()
    }
  }

  func startOnBoardingCoordinator(skip: OnBoardingCoordinator.Skip = .welcome) {
    guard let router = (self.router as? AppDelegateRouter) else { return }
    navigationController = router.navigationController
    router.start()
    let childRouter = OnBoardingNavigationRouter(navigationController: navigationController)
    let coordinator = OnBoardingCoordinator(router: childRouter)
    coordinator.skip = skip
    presentChild(coordinator, animated: true) {
      self.startHomeCoordinator()
    }
  }

  func startHomeCoordinator() {
    guard let router = (self.router as? AppDelegateRouter) else { return }
    navigationController = router.navigationController
    navigationController.viewControllers = []
    router.start()
    let childRouter = OnBoardingNavigationRouter(navigationController: navigationController)
    let coordinator = HomeCoordinator(router: childRouter)
    presentChild(coordinator, animated: true)
    
  }
}

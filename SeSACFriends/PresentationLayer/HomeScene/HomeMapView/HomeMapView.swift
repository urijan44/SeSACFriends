//
//  HomeMapView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/26.
//

import UIKit
import SeSACFriendsUIKit
import NMapsMap
import SnapKit
import SwiftUI

final class HomeMapView: RepresentableViewController {

  let rootView: RootView

  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    rootView.viewController = self
  }

  init(rootView: RootView) {
    self.rootView = rootView
    super.init()
  }
}

struct HomeMapViewRepresentable: UIViewControllerRepresentable {
  let router: SwiftUIRouter
  func makeUIViewController(context: Context) -> HomeMapView {
    configureView(router: router)
  }

  func updateUIViewController(_ uiViewController: HomeMapView, context: Context) {
    
  }
}

extension HomeMapViewRepresentable {
  func configureView(router: SwiftUIRouter) -> HomeMapView {
    let coreLocationRepository = DefaultCoreLocationRepository()
    let serverRepository = DefaultServerRepository(remoteAPIService: .init())
    let useCase = DefaultHomeMapUseCase(coreLocationRepository: coreLocationRepository, serverRepository: serverRepository)
    let viewModel = HomeMapView.RootView.ViewModel(useCase: useCase, router: router)
    let rootView = HomeMapView.RootView(viewModel: viewModel)
    let homeMapView = HomeMapView(rootView: rootView)
    return homeMapView
  }
}

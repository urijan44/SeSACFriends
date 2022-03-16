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
  func makeUIViewController(context: Context) -> HomeMapView {
    configureView()
  }

  func updateUIViewController(_ uiViewController: HomeMapView, context: Context) {
    
  }
}

extension HomeMapViewRepresentable {
  func configureView() -> HomeMapView {
    let repository = DefaultCoreLocationRepository()
    let useCase = DefaultCoreLocationUseCase(coreLocationRepository: repository)
    let viewModel = HomeMapView.RootView.ViewModel(useCase: useCase)
    let rootView = HomeMapView.RootView(viewModel: viewModel)
    let homeMapView = HomeMapView(rootView: rootView)
    return homeMapView
  }
}

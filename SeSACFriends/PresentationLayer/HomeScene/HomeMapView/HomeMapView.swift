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

final class HomeMapView: UIViewController {

  lazy var rootView = RootView(viewModel: .init())

  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

  }
}

struct HomeMapViewRepresentable: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> HomeMapView {
    HomeMapView()
  }

  func updateUIViewController(_ uiViewController: HomeMapView, context: Context) {
    
  }
}

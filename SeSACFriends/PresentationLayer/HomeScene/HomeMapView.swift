//
//  HomeMapView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/26.
//

import UIKit
import NMapsMap
import SnapKit
import SwiftUI

final class HomeMapView: UIViewController {

  lazy var mapView = NMFMapView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(mapView)

    mapView.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview().inset(12)
      make.height.equalTo(mapView.snp.width)
    }
  }
}

struct HomeMapViewRepresentable: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> HomeMapView {
    HomeMapView()
  }

  func updateUIViewController(_ uiViewController: HomeMapView, context: Context) {
    
  }
}

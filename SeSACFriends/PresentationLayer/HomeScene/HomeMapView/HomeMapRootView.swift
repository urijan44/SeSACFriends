//
//  HomeMapRootView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/28.
//

import UIKit
import SeSACFriendsUIKit
import NMapsMap

extension HomeMapView {
  final class RootView: RepresentableView {

    lazy var mapView = NMFMapView()
    private let genderFilter = VerticalGenderPicker(viewWidth: 48)
    private let currentLocationButton = LocationButton()

    override func createView() {
      addSubview(mapView)
      addSubview(genderFilter)
      addSubview(currentLocationButton)
    }

    override func layoutConfigure() {
      mapView.snp.makeConstraints { make in
        make.leading.trailing.equalToSuperview()
        make.top.equalToSuperview()
        make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
      }

      genderFilter.snp.makeConstraints { make in
        make.width.equalTo(48)
        make.height.equalTo(48 * 3)
        make.leading.equalTo(snp.leading).offset(16)
        make.top.equalTo(snp.top).offset(52)
      }

      currentLocationButton.snp.makeConstraints { make in
        make.size.equalTo(48)
        make.top.equalTo(genderFilter.snp.bottom).offset(16)
        make.leading.equalTo(genderFilter.snp.leading)
      }
    }
  }
}

#if DEBUG

import SwiftUI
struct HomeMapRootViewUI: UIViewRepresentable {
  func makeUIView(context: Context) -> HomeMapView.RootView {
    HomeMapView.RootView()
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {

  }
}

struct HomeMapRootViewUI_Previews: PreviewProvider {
  static var previews: some View {
    HomeMapRootViewUI()
  }
}
#endif

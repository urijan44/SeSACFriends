//
//  HomeMapRootView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/28.
//

import UIKit
import SeSACFriendsUIKit
import NMapsMap
import CoreLocation
import RxSwift

extension HomeMapView {
  final class RootView: RepresentableView {

    let viewModel: ViewModel
    private var bag = DisposeBag()
    weak var viewController: UIViewController?

    let mapView = NMFMapView()

    private let genderFilter = VerticalGenderPicker(viewWidth: 48)
    private let currentLocationButton = LocationButton()
    private let matchButton = MatchingStateButton()
    private lazy var mapCenterMarkerButton: UIButton = {
      let button = UIButton()
      button.setImage(AssetImage.mapMarker.image, for: .normal)
      return button
    }()

    private lazy var centerMarker: NMFMarker = {
      let marker = NMFMarker()
      marker.iconImage = NMFOverlayImage(image: AssetImage.mapMarker.image)
      marker.touchHandler = viewModel.mapMarkerTouchHandler(overlay:)
      return marker
    }()

    init(viewModel: ViewModel) {
      self.viewModel = viewModel
      super.init(frame: .zero)
    }

    override func createView() {
      addSubview(mapView)
      addSubview(genderFilter)
      addSubview(currentLocationButton)
      addSubview(matchButton)
      addSubview(mapCenterMarkerButton)
      mapView.addCameraDelegate(delegate: viewModel)
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

      matchButton.snp.makeConstraints { make in
        make.size.equalTo(64)
        make.trailing.equalToSuperview().offset(-16)
        make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
      }

      mapCenterMarkerButton.snp.makeConstraints { make in
        make.size.equalTo(48)
        make.centerX.equalTo(mapView)
        make.centerY.equalTo(mapView).offset(-24)
      }
    }

    override func bind() {
      let input = ViewModel.Input(
        tapCenterButton: mapCenterMarkerButton.rx.tap.asObservable(),
        currentUserButton: currentLocationButton.rx.tap.asObservable(),
        viewDidMove: self.rx.methodInvoked(#selector(UIView.didMoveToWindow)).map{_ in},
        tapMatchButton: matchButton.rx.tap.asObservable()
      )

      let output = viewModel.transform(input)
      output.centerButtonHidden
        .asDriver()
        .drive(mapCenterMarkerButton.rx.isHidden)
        .disposed(by: bag)

      output.showCenterMarker
        .subscribe(onNext: { [unowned self] in
          centerMarker.mapView = $0 == true ? mapView : nil
      }).disposed(by: bag)

      output.markerCoordinator
        .subscribe(onNext: { [unowned self] in
          centerMarker.position = NMGLatLng(lat: $0.0, lng: $0.1)
        }).disposed(by: bag)

      output.currentLocation
        .distinctUntilChanged({ lhs, rhs in
          lhs.longitude == rhs.longitude &&
          lhs.latitude == rhs.latitude
        })
        .subscribe(onNext: { [unowned self] location in
          let cameraUpdate = NMFCameraUpdate(
            scrollTo: NMGLatLng(lat: location.latitude, lng: location.longitude)
            , zoomTo: Constant.Map.defaultZoomLevel)
          cameraUpdate.animation = .easeIn
          mapView.moveCamera(cameraUpdate)
        }).disposed(by: bag)

      output.showLocationAlert
        .share(replay: 1)
        .observe(on: MainScheduler.asyncInstance)
        .subscribe(onNext: { [weak self] alert in
          self?.viewController?.present(alert, animated: true)
        }).disposed(by: bag)

      output.showToast.subscribe(onNext: { [unowned self] toast in
        let message = toast.sendingMessage
        showToast(message)
      }).disposed(by: bag)
    }
  }
}

#if DEBUG

import SwiftUI
struct HomeMapRootViewUI: UIViewRepresentable {

  class CoreLocationUseCaseSpy: HomeMapUseCase {
    func requestInputHobbyField(completion: @escaping (Bool, ToastMessage.HomeView?) -> Void) {

    }
    func requestUserLocation(completion: @escaping (CLLocationCoordinate2D?, CLAuthorizationStatus) -> Void) { }

    func requestPermission() { }

    func requestAuthStatus() { }
  }

  final class HomeMapRouterSpy: SwiftUIRouter { }

  func makeUIView(context: Context) -> HomeMapView.RootView {
    HomeMapView.RootView(viewModel: .init(useCase: CoreLocationUseCaseSpy(), router: HomeMapRouterSpy()))
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

//
//  HomeMapViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/03/14.
//

import UIKit
import RxSwift
import RxRelay
import NMapsMap
import SeSACFriendsUIKit

extension HomeMapView.RootView {
  final class ViewModel: NSObject {
    typealias Coordinator2d = (latitude: Double, longitude: Double)

    private var bag = DisposeBag()
    private var logic = HomeMapViewLogic()

    private let useCase: CoreLocationUseCase

    init(useCase: CoreLocationUseCase) {
      self.useCase = useCase
    }

    struct Input {
      let tapCenterButton: Observable<Void>
      let currentUserButton: Observable<Void>
      let viewDidMove: Observable<Void>
    }

    struct Output{
      let centerButtonHidden: BehaviorRelay<Bool> = .init(value: false)
      let showCenterMarker: BehaviorRelay<Bool> = .init(value: false)
      let markerCoordinator: BehaviorRelay<(Double, Double)> = .init(value: (0,0))
      let currentLocation: BehaviorRelay<CLLocationCoordinate2D> = .init(value: .init())
      let showLocationAlert: PublishRelay<UIAlertController> = .init()
    }

    func transform(_ input: Input) -> Output {
      let output = Output()

      input.tapCenterButton.subscribe(onNext: { [unowned self] _ in
        logic.tapCenterButtonSignal()
      }).disposed(by: bag)

      input.currentUserButton.subscribe(onNext: { [unowned self] _ in
        useCase.requestUserLocation { [unowned self] location, status in
          switch status {
            case .restricted, .denied:
              output.showLocationAlert.accept(showLocationServiceEnableAlert())
            case .authorizedAlways, .authorizedWhenInUse:
              guard let location = location else { return }
              output.currentLocation.accept(location)
            default:
              useCase.requestPermission()
          }
        }
      }).disposed(by: bag)

      input.viewDidMove.subscribe(onNext: {
        let makeCoordinate2d = CLLocationCoordinate2DMake(
          Constant.Map.initialLocation.latitude,
          Constant.Map.initialLocation.longitude)
        output.currentLocation.accept(makeCoordinate2d)
      }).disposed(by: bag)

      logic.centerButtonHidden.subscribe(onNext: {
        output.centerButtonHidden.accept($0)
      }).disposed(by: bag)

      logic.showCenterMarker.subscribe(onNext: {
        output.showCenterMarker.accept($0)
      }).disposed(by: bag)

      logic.coordinator.subscribe(onNext: {
        output.markerCoordinator.accept($0)
      }).disposed(by: bag)

      return output
    }

    func mapMarkerTouchHandler(overlay: NMFOverlay) -> Bool {
      logic.mapMarkerTouchHandler()
      return true
    }

    func showLocationServiceEnableAlert() -> UIAlertController {
      let alert = UIAlertController(
        title: "Location Services Disabled",
        message: "Please enable location services for this app in Settings",
        preferredStyle: .alert)

      let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
      alert.addAction(okAction)

      let cancel = UIAlertAction(title: "Cancel", style: .cancel)
      alert.addAction(cancel)
      return alert
    }
  }
}

extension HomeMapView.RootView.ViewModel: NMFMapViewCameraDelegate {
  func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
    guard !logic.showCenterMarker.value else { return }
    let camPosition = mapView.cameraPosition
    logic.updateCoordinate(
      latitude: camPosition.target.lat,
      longitude: camPosition.target.lng)
  }
}

final class HomeMapViewLogic {
  let centerButtonHidden: BehaviorRelay<Bool> = .init(value: false)
  let showCenterMarker: BehaviorRelay<Bool> = .init(value: false)
  var coordinator: BehaviorRelay<(latitude: Double, longitude: Double)> = .init(value: (0,0))

  func mapMarkerTouchHandler() {
    showCenterMarker.accept(false)
    centerButtonHidden.accept(false)
  }

  func tapCenterButtonSignal() {
    showCenterMarker.accept(true)
    centerButtonHidden.accept(true)
  }

  func updateCoordinate(latitude: Double, longitude: Double) {
    coordinator.accept((latitude, longitude))
  }
}

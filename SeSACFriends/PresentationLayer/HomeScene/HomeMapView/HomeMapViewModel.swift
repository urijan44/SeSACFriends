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

extension HomeMapView.RootView {
  final class ViewModel: NSObject {
    typealias Coordinator2d = (latitude: Double, longitude: Double)

    private var bag = DisposeBag()
    private var logic = HomeMapViewLogic()

    struct Input {
      let tapCenterButton: Observable<Void>
    }

    struct Output{
      let centerButtonHidden: BehaviorRelay<Bool> = .init(value: false)
      let showCenterMarker: BehaviorRelay<Bool> = .init(value: false)
      let markerCoordinator: BehaviorRelay<(Double, Double)> = .init(value: (0, 0))
    }

    func transform(_ input: Input) -> Output {
      let output = Output()

      input.tapCenterButton.subscribe(onNext: { [unowned self] _ in
        logic.tapCenterButtonSignal()
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

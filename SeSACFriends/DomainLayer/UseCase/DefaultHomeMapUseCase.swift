//
//  CoreLocationUserCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/03/16.
//

import Foundation
import RxSwift
import CoreLocation

protocol HomeMapUseCase {
  func requestUserLocation(completion: @escaping (CLLocationCoordinate2D?, CLAuthorizationStatus) -> Void)
  func requestPermission()
  func requestInputHobbyField(completion: @escaping (Bool, ToastMessage.HomeView?) -> Void)
}

final class DefaultHomeMapUseCase {

  private let coreLocationRepository: CoreLocationRepository
  private let serverRepository: ServerRepository
  var authStatus: CLAuthorizationStatus = .notDetermined

  init(coreLocationRepository: CoreLocationRepository,
       serverRepository: ServerRepository) {
    self.coreLocationRepository = coreLocationRepository
    self.serverRepository = serverRepository
  }

  func requestAuthStatus() {
    authStatus = coreLocationRepository.locationPermission()
  }
}

extension DefaultHomeMapUseCase: HomeMapUseCase {
  func requestUserLocation(completion: @escaping (CLLocationCoordinate2D?, CLAuthorizationStatus) -> Void) {
    coreLocationRepository.currentUserLocation { [unowned self] (locations, status) in
      if locations.isEmpty {
        completion(nil, status)
        return
      }

      guard let location = locations.last else { return }
      authStatus = status
      completion(location.coordinate, .authorizedWhenInUse)
    }
  }

  func requestPermission() {
    coreLocationRepository.requestPermission()
    requestAuthStatus()
  }

  func requestInputHobbyField(completion: @escaping (Bool, ToastMessage.HomeView?) -> Void) {
    guard authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse else {
      requestPermission()
      return
    }

    guard serverRepository.loadUserProfile().gender != -1 else {
      let toast = ToastMessage.HomeView()
      completion(false, toast)
      return
    }

    completion(true, nil)
  }
}

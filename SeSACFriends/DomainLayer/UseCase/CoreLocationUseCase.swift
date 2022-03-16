//
//  CoreLocationUserCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/03/16.
//

import Foundation
import RxSwift
import CoreLocation

protocol CoreLocationUseCase {
  func requestUserLocation(completion: @escaping (CLLocationCoordinate2D?, CLAuthorizationStatus) -> Void)
  func requestPermission()
}

final class DefaultCoreLocationUseCase {
  private let coreLocationRepository: CoreLocationRepository

  init(coreLocationRepository: CoreLocationRepository) {
    self.coreLocationRepository = coreLocationRepository
  }
}

extension DefaultCoreLocationUseCase: CoreLocationUseCase {
  func requestUserLocation(completion: @escaping (CLLocationCoordinate2D?, CLAuthorizationStatus) -> Void) {
    coreLocationRepository.currentUserLocation { (locations, status) in
      if locations.isEmpty {
        completion(nil, status)
        return
      }

      guard let location = locations.last else { return }
      completion(location.coordinate, .authorizedWhenInUse)
    }
  }

  func requestPermission() {
    coreLocationRepository.requestPermission()
  }
}

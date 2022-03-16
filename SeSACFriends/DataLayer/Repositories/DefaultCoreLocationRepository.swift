//
//  DefaultCoreLocationRepository.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/03/16.
//

import Foundation
import RxSwift
import CoreLocation

final class DefaultCoreLocationRepository: NSObject, CoreLocationRepository {
  private let locationManager = CLLocationManager()
  private var locations: [CLLocation] = []

  func currentUserLocation(handler: @escaping (([CLLocation], CLAuthorizationStatus) -> Void)) {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.startUpdatingLocation()

    handler(locations, locationPermission())
  }

  func stopUserLocation() {
    locationManager.delegate = nil
  }

  func locationPermission() -> CLAuthorizationStatus {
    let authStatus: CLAuthorizationStatus
    if #available(iOS 14.0, *) {
      authStatus = locationManager.authorizationStatus
    } else {
      authStatus = CLLocationManager.authorizationStatus()
    }
    return authStatus
  }

  func requestPermission() {
    locationManager.requestWhenInUseAuthorization()
  }
}

extension DefaultCoreLocationRepository: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    self.locations = locations
    guard let lastLocation = locations.last else { return }
    if lastLocation.horizontalAccuracy <= locationManager.desiredAccuracy { stopUserLocation() }
  }
}

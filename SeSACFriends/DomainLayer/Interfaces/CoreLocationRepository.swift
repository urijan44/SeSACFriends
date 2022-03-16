//
//  CoreLocationRepository.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/03/16.
//

import Foundation
import CoreLocation

protocol CoreLocationRepository {
  func currentUserLocation(handler: @escaping (([CLLocation], CLAuthorizationStatus) -> Void))
  func requestPermission()
}

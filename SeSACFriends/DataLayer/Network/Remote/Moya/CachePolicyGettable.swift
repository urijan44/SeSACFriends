//
//  CachePolichGettable.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/03/22.
//

import Foundation
import Moya

protocol CachePolicyGettable {
  var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    if let cachePolicyGettable = target as? CachePolicyGettable {
      var mutableRequest = request
      mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
      return mutableRequest
    }
    return request
  }
}

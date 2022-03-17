//
//  Constant.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/18.
//

import UIKit

public struct Constant {

  static let cornerRadius: CGFloat = 8

  struct Font {
    static let notoSansKRr = "NotoSansKR-Regular"
    static let notoSansKRm = "NotoSansKR-Medium"
  }

  public struct Map {
    public static let minZoomLevel: Double = 5
    public static let maxZoomLevel: Double = 15
    public static let defaultZoomLevel: Double = 14
    public static let initialLocation = (latitude: 37.517819364682694, longitude: 126.88647317074734)
  }
}

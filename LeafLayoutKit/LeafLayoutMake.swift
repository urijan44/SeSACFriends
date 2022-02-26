//
//  LeafLayoutMake.swift
//  LeafLayoutKit
//
//  Created by hoseung Lee on 2022/02/27.
//

import UIKit
public enum LeafLayoutMake {
  case leading(constant: CGFloat, target: UIView? = nil, anchor: LeafLayout.Anchor? = nil)
  case trailing(constant: CGFloat, target: UIView? = nil, anchor: LeafLayout.Anchor? = nil)
  case top(constant: CGFloat, target: UIView? = nil, anchor: LeafLayout.Anchor? = nil)
  case bottom(constant: CGFloat, target: UIView? = nil, anchor: LeafLayout.Anchor? = nil)
  case height(constant: CGFloat, target: UIView? = nil, anchor: LeafLayout.Anchor? = nil)
  case width(constant: CGFloat, target: UIView? = nil, anchor: LeafLayout.Anchor? = nil)

  var anchor: LeafLayout.Anchor {
    switch self {
      case .leading:
        return .leading
      case .trailing:
        return .trailing
      case .top:
        return .top
      case .bottom:
        return .bottom
      case .height:
        return .height
      case .width:
        return .width
    }
  }

  var constant: CGFloat {
    switch self {
      case .leading(let constant, _, _):
        return constant
      case .trailing(let constant, _, _):
        return constant
      case .top(let constant, _, _):
        return constant
      case .bottom(let constant, _, _):
        return constant
      case .height(let constant, _, _), .width(let constant, _, _):
        return constant
    }
  }

  var target: UIView? {
    switch self {
      case .leading(_, let target, _):
        return target
      case .trailing(_, let target, _):
        return target
      case .top(_, let target, _):
        return target
      case .bottom(_, let target, _):
        return target
      case .height(_, let target, _), .width(_, let target, _):
        return target
    }
  }

  var targetAnchor: LeafLayout.Anchor? {
    switch self {
      case .leading(_, _, let anchor),
          .trailing(_, _, let anchor),
          .top(_, _, let anchor),
          .bottom(_, _, let anchor),
          .width(_, _, let anchor),
          .height(_, _, let anchor)
        :
        return anchor
    }
  }
}

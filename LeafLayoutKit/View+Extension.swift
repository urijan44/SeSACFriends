//
//  View+Extension.swift
//  LeafLayoutKit
//
//  Created by hoseung Lee on 2022/02/27.
//

import UIKit
public extension UIView {
  func customLayout(_ superView: UIView, _ anchors: ([LeafLayoutMake])) {
    self.translatesAutoresizingMaskIntoConstraints = false

    anchors.forEach { layout in
      let leafLayout = LeafLayout(
        anchor: layout.anchor,
        constant: layout.constant,
        target: layout.target,
        targetAnchor: layout.targetAnchor
      )

      switch leafLayout.anchor {
        case .leading, .trailing, .top, .bottom, .centerX, .centerY:
          NSLayoutConstraint(
            item: self,
            attribute: leafLayout.anchor.nsAnchor,
            relatedBy: .equal,
            toItem: leafLayout.target == nil ? superView : leafLayout.target,
            attribute: leafLayout.targetAnchor == nil ? leafLayout.anchor.nsAnchor : leafLayout.targetAnchor!.nsAnchor,
            multiplier: 1,
            constant: layout.constant).isActive = true
        case .width, .height:
          if layout.constant == 0 {
            NSLayoutConstraint(
              item: self,
              attribute: leafLayout.anchor.nsAnchor,
              relatedBy: .equal,
              toItem: leafLayout.target == nil ? superView : leafLayout.target,
              attribute: leafLayout.targetAnchor == nil ? leafLayout.anchor.nsAnchor : leafLayout.targetAnchor!.nsAnchor,
              multiplier: 1,
              constant: layout.constant).isActive = true
          } else {
            NSLayoutConstraint(
              item: self,
              attribute: leafLayout.anchor.nsAnchor,
              relatedBy: .equal,
              toItem: nil,
              attribute: .notAnAttribute,
              multiplier: 1, constant: layout.constant).isActive = true
          }
      }
    }
  }
}

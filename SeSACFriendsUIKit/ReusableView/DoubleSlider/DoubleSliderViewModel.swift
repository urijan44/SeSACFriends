//
//  DoubleSliderViewModel.swift
//  DoubleSlider
//
//  Created by hoseung Lee on 2022/02/13.
//

import SwiftUI

final public class DoubleSliderViewModel: ObservableObject {
  @Binding var leftValue: Int
  @Binding var rightValue: Int
  @State private var leftPreviousOffsetX: CGFloat = 0
  @State private var rightPreviousOffsetX: CGFloat = 0
  @Published private var leftTransform: Transform
  @Published private var rightTransform: Transform

  private let minValue: Int
  private let maxValue: Int

  let inactiveColor = Color(.seSACGray2)
  let activeColor = Color(.seSACGreen)
  let ballSize: CGFloat = 22
  let viewSize: CGFloat

  private var unit: CGFloat {
    (viewSize - ballSize * 2) / CGFloat(maxValue - minValue)
  }

  public init(minValue: Int, maxValue: Int, leftValue: Binding<Int>, rightValue: Binding<Int>, viewSize: CGFloat) {

    self.minValue = minValue
    self.maxValue = maxValue

    self._leftValue = leftValue
    self._rightValue = rightValue
    self.viewSize = viewSize
    let unit = (viewSize - ballSize * 2) / CGFloat(maxValue - minValue)
    self.leftTransform = Transform(ballSize: 22, xOffset: unit * CGFloat(leftValue.wrappedValue - minValue))
    self.rightTransform = Transform(ballSize: 22, xOffset: -(unit * CGFloat(maxValue - rightValue.wrappedValue)))
    self.leftPreviousOffsetX = unit * CGFloat(leftValue.wrappedValue - minValue)
    self.rightPreviousOffsetX = -(unit * CGFloat(maxValue - rightValue.wrappedValue))
  }

  func leftDragOnChaned(_ value: DragGesture.Value) {
    if leftValue >= minValue && leftValue < rightValue {
      leftTransform.xOffset = value.translation.width + leftPreviousOffsetX
      leftValue = calculating(.left)
    }

    if leftValue >= rightValue && value.translation.width < 0 {
      leftTransform.xOffset = value.translation.width + leftPreviousOffsetX
      leftValue = calculating(.left)
    }
  }

  func leftDragEnd() {
    if leftValue < minValue {
      leftTransform.xOffset = 0
      leftValue = calculating(.left)
    }

    if leftValue > rightValue {
      let distance = leftValue - rightValue
      leftTransform.xOffset -= (CGFloat(distance) * unit)
      leftValue = calculating(.left)
    }
    leftPreviousOffsetX = leftTransform.xOffset
  }

  func rightDragOnChanged(_ value: DragGesture.Value) {
    if rightValue <= maxValue && rightValue > leftValue {
      rightTransform.xOffset = value.translation.width + rightPreviousOffsetX
      rightValue = calculating(.right)
    }

    if rightValue <= leftValue && value.translation.width > 0 {
      rightTransform.xOffset = value.translation.width + rightPreviousOffsetX
      rightValue = calculating(.right)
    }
  }

  func rightDragEnded() {
    if rightValue > maxValue {
      rightTransform.xOffset = 0
      rightValue = calculating(.right)
    }

    if rightValue < leftValue {
      let distance = leftValue - rightValue
      rightTransform.xOffset += (CGFloat(distance) * unit)
      rightValue = calculating(.right)
    }

    rightPreviousOffsetX = rightTransform.xOffset
  }

  private func calculating(_ direction: Direction) -> Int {
    switch direction {
      case .left:
        return Int(Double(leftTransform.xOffset / unit) + Double(minValue))
      case .right:
        return Int(Double(Double(maxValue) + (rightTransform.xOffset) / unit))
    }
  }

  var leftbarWidth: CGFloat {
    abs(leftTransform.xOffset)
  }

  var rightBarWidth: CGFloat {
    abs(rightTransform.xOffset)
  }

  var leftBallXOffset: CGFloat {
    leftTransform.xOffset
  }

  var rightBallXOffset: CGFloat {
    rightTransform.xOffset
  }

  enum Direction {
    case left
    case right
  }

  struct Transform {
    var size: CGSize
    var xOffset: CGFloat = 0

    init(ballSize: Int, xOffset: CGFloat) {
      self.size = CGSize(width: ballSize, height: ballSize)
      self.xOffset = xOffset
    }
  }
}

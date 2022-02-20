//
//  DoubleSlider.swift
//  DoubleSlider
//
//  Created by hoseung Lee on 2022/02/13.
//

import SwiftUI

public struct DoubleSlider: View {

  @Binding var leftValue: Int
  @Binding var rightValue: Int

  @State var leftPreviousOffsetX: CGFloat = 0
  @State var rightPreviousOffsetX: CGFloat = 0
  @State var leftTransform: Transform = Transform(ballSize: 0, xOffset: 0)
  @State var rightTransform: Transform = Transform(ballSize: 0, xOffset: 0)

  let minValue: Int = 18
  let maxValue: Int = 65

  let inactiveColor = Color(.seSACGray2)
  let activeColor = Color(.seSACGreen)
  let ballSize: CGFloat = 22

  var unit: CGFloat

  @State var viewSize: CGFloat

  @State private var leftOnce = true
  @State private var rightOnce = true

  public var body: some View {
    let leftDrag = DragGesture()
      .onChanged { value in
        leftDragOnChaned(value)
      }
      .onEnded { _ in
        leftDragEnd()
      }

    let rightDrag = DragGesture()
      .onChanged {
        rightDragOnChanged($0)
      }
      .onEnded { _ in
        rightDragEnded()
      }
    VStack {
      ZStack {
        HStack(spacing: 0) {
          Rectangle()
            .frame(width: leftbarWidth, height: 4, alignment: .leading)
            .foregroundColor(inactiveColor)
          Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 4)
            .foregroundColor(activeColor)
          Rectangle()
            .frame(width: rightBarWidth, height: 4)
            .foregroundColor(inactiveColor)
        }
        HStack {
          Ball()
            .frame(width: ballSize, height: ballSize)
            .offset(x: leftBallXOffset, y: 0)
            .gesture(leftDrag)
          Spacer()
          Ball()
            .frame(width: ballSize, height: ballSize)
            .offset(x: rightBallXOffset, y: 0)
            .gesture(rightDrag)
        }
      }
    }
    .onChange(of: leftValue) { newValue in
      if leftOnce {
        self.leftTransform = Transform(ballSize: 22, xOffset: unit * CGFloat(leftValue - minValue))
        self.leftPreviousOffsetX = unit * CGFloat(leftValue - minValue)
        leftOnce = false
      }

    }
    .onChange(of: rightValue) { newValue in
      if rightOnce {
        self.rightTransform = Transform(ballSize: 22, xOffset: -(unit * CGFloat(maxValue - rightValue)))
        self.rightPreviousOffsetX = -(unit * CGFloat(maxValue - rightValue))
        rightOnce = false
      }
    }
  }

  public init(leftValue: Binding<Int>, rightValue: Binding<Int>, viewSize: CGFloat) {
    self._leftValue = leftValue
    self._rightValue = rightValue
    self.viewSize = viewSize

    unit = (viewSize - ballSize * 2) / CGFloat(maxValue - minValue)
  }
}

fileprivate struct Ball: View {

  public var color: Color = Color(.seSACGreen)
  public var innerBallColor: Color = .white

  var body: some View {
    GeometryReader { proxy in
      Circle()
        .foregroundColor(color)
        .overlay(
          Circle()
            .strokeBorder(innerBallColor, lineWidth: 1)
        )
    }
    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
  }
}

fileprivate struct DoubleSlider_Previews: PreviewProvider {
  static var previews: some View {
    DoubleSlider(leftValue: .constant(18), rightValue: .constant(65), viewSize: 350)
  }
}

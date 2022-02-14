//
//  DoubleSlider.swift
//  DoubleSlider
//
//  Created by hoseung Lee on 2022/02/13.
//

import SwiftUI

public struct DoubleSlider: View {

  @ObservedObject var viewModel: DoubleSliderViewModel

  public var body: some View {
    let leftDrag = DragGesture()
      .onChanged { value in
        viewModel.leftDragOnChaned(value)
      }
      .onEnded { _ in
        viewModel.leftDragEnd()
      }

    let rightDrag = DragGesture()
      .onChanged {
        viewModel.rightDragOnChanged($0)
      }
      .onEnded { _ in
        viewModel.rightDragEnded()
      }
    VStack {
      ZStack {
        HStack(spacing: 0) {
          Rectangle()
            .frame(width: viewModel.leftbarWidth, height: 4, alignment: .leading)
            .foregroundColor(viewModel.inactiveColor)
          Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 4)
            .foregroundColor(viewModel.activeColor)
          Rectangle()
            .frame(width: viewModel.rightBarWidth, height: 4)
            .foregroundColor(viewModel.inactiveColor)
        }
        HStack {
          Ball()
            .frame(width: viewModel.ballSize, height: viewModel.ballSize)
            .offset(x: viewModel.leftBallXOffset, y: 0)
            .gesture(leftDrag)
          Spacer()
          Ball()
            .frame(width: viewModel.ballSize, height: viewModel.ballSize)
            .offset(x: viewModel.rightBallXOffset, y: 0)
            .gesture(rightDrag)
        }
      }
    }
  }

  public init(leftValue: Binding<Int>, rightValue: Binding<Int>, viewSize: CGFloat) {
    let viewModel = DoubleSliderViewModel(minValue: 18, maxValue: 65, leftValue: leftValue, rightValue: rightValue, viewSize: viewSize)
    self.viewModel = viewModel
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

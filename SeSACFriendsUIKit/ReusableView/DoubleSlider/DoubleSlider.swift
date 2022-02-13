//
//  DoubleSlider.swift
//  DoubleSlider
//
//  Created by hoseung Lee on 2022/02/13.
//

import SwiftUI

struct ContentView: View {
  @State var minAge: String = "18"
  @State var maxAge: String = "65"
  @ObservedObject var viewModel = DoubleSliderViewModel(minValue: 1, maxValue: 100000, leftValue: 18, rightValue: 65, viewSize: UIScreen.main.bounds.width - 32)


  var body: some View {

    GeometryReader { geometry in
      VStack {
        HStack {
          VStack {
            Text(viewModel.leftValue.description)
            TextField("최저나이", text: $minAge)
          }
          .background(
          RoundedRectangle(cornerRadius: 8)
            .foregroundColor(Color("SeSACGray2"))
          )
          VStack {
            Text(viewModel.rightValue.description)
            TextField("최대나이", text: $maxAge)
          }
          .background(
          RoundedRectangle(cornerRadius: 8)
            .foregroundColor(Color("SeSACGray2"))
          )
        }
        .padding(16)
        DoubleSlider(viewModel: viewModel)
          .padding(16)
      }
    }

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

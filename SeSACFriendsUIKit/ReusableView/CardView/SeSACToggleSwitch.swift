//
//  SeSACToggleSwitch.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/11.
//

import SwiftUI

struct SeSACToggleSwitch: View {

  @Binding var isOn: Bool
  var body: some View {
    GeometryReader { proxy in
      ZStack {
        RoundedRectangle(cornerRadius: proxy.size.height / 2)
          .foregroundColor(isOn ? Color(.seSACGreen) : Color(.seSACGray4))
        Circle()
          .foregroundColor(.white)
          .frame(width: proxy.size.height * 0.82, height: proxy.size.height * 0.82)
          .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 3)
          .position(x: isOn ?
                    proxy.size.width - proxy.size.height / 2 :
                      proxy.size.height / 2,
                    y: proxy.size.height / 2)
      }
    }
    .onTapGesture {
      withAnimation(.easeInOut(duration: 0.3)) {
        isOn.toggle()
      }
    }
  }
}

struct SeSACToggleSwitch_Previews: PreviewProvider {
  static var previews: some View {
    SeSACToggleSwitch(isOn: .constant(true))
      .frame(width: 104, height: 56)
      .previewLayout(.sizeThatFits)
  }
}

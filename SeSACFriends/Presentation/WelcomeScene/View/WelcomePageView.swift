//
//  WelcomePageView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import SwiftUI
import SeSACFriendsUIKit

struct WelcomePageView: View {
  var body: some View {
    TabView {
      WelcomeImageViewRP(
        titleImage: Images.onboardingText1.image,
        bodyImage: Images.onboardingImg1.image)
      WelcomeImageViewRP(
        titleImage: Images.onboardingText2.image,
        bodyImage: Images.onboardingImg2.image)
      WelcomeImageViewRP(
        titleImage: Images.onboardingText3.image,
        bodyImage: Images.onboardingImg3.image)
    }
    .tabViewStyle(.page(indexDisplayMode: .always))
  }
}

struct WelcomePageView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomePageView()
      .preferredColorScheme(.dark)
  }
}

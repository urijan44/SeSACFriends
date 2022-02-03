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
        titleImage: AssetImage.onboardingText1.image,
        bodyImage: AssetImage.onboardingImg1.image)
      WelcomeImageViewRP(
        titleImage: AssetImage.onboardingText2.image,
        bodyImage: AssetImage.onboardingImg2.image)
      WelcomeImageViewRP(
        titleImage: AssetImage.onboardingText3.image,
        bodyImage: AssetImage.onboardingImg3.image)
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

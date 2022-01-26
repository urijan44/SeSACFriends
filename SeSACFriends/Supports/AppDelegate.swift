//
//  AppDelegate.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/18.
//

import UIKit
import SeSACFriendsUIKit
import Firebase
import Toast

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    UIPageControl.appearance().currentPageIndicatorTintColor = .seSACBlack
    UIPageControl.appearance().pageIndicatorTintColor = .seSACGray6

    ToastManager.shared.isTapToDismissEnabled = true

    Thread.sleep(forTimeInterval: 2.0)

    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

  }

  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

  }
}

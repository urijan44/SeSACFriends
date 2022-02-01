//
//  AppDelegate.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/18.
//

import UIKit
import SeSACFriendsUIKit
import UserNotifications
import Firebase
import FirebaseMessaging
import FirebaseAnalytics
import Toast

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  let center = UNUserNotificationCenter.current()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    UIPageControl.appearance().currentPageIndicatorTintColor = .seSACBlack
    UIPageControl.appearance().pageIndicatorTintColor = .seSACGray6
    UIBarButtonItem.appearance().tintColor = .seSACBlack
    ToastManager.shared.isTapToDismissEnabled = true

    center.delegate = self
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    center.requestAuthorization(options: authOptions) { _, _ in
      DispatchQueue.main.async {
        application.registerForRemoteNotifications()
      }
    }

    Messaging.messaging().delegate = self

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

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
  }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.badge, .banner, .sound])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    completionHandler()
  }
}

extension AppDelegate: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    let tokenDict = ["token": fcmToken ?? ""]
    UserDefaults.standard.set(fcmToken, forKey: "FCMToken")
    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: tokenDict)
  }
}

//
//  AppDelegate.swift
//  JMK
//
//  Created by Mahmoud Tawab on 4/24/21.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    static let PostNotification = NSNotification.Name(rawValue: "Notification")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        LodBaseUrl()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        
        let ControllerNav = UINavigationController(rootViewController: LaunchScreen())
        ControllerNav.navigationBar.isHidden = true
        window?.rootViewController = ControllerNav
        
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Close"
        IQKeyboardManager.shared.toolbarBarTintColor = .white
   
        // Facebook config
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        

        // Notifications config
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: {_, _ in })
        } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        return true
    }
    

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // google config
        return GIDSignIn.sharedInstance.handle(url)
    }
    


    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    // facebook config
    return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }
        print(userInfo)
      }

      // [START receive_message]
      func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
      }
      // [END receive_message]
      func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
      }
    
      func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
      }

}

extension AppDelegate : UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
        
    NotificationCenter.default.post(name: AppDelegate.PostNotification, object: nil)
    }
    if #available(iOS 14.0, *) {
        completionHandler([.banner, .sound])
    } else {
        completionHandler([[.alert, .sound]])
    }
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    print(userInfo)
    completionHandler()
  }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
  // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(String(describing: fcmToken))")
        
    }
    
  }
  


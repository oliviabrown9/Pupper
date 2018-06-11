//
//  AppDelegate.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let notifCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        notifCenter.requestAuthorization(options: options) {
                        (granted, error) in
                        guard granted else { return }
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
        }
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0)
        UINavigationBar.appearance().barTintColor = UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    let tokenParts = deviceToken.map { data -> String in
//        return String(format: "%02.2hhx", data)
//    }
//    let token = tokenParts.joined()
//    }
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        // 1. Print out error if PNs registration not successful
//        print("Failed to register for remote notifications with error: \(error)")
//    }
//
//    func registerForPushNotifications() {
//        UNUserNotificationCenter.current().delegate = self
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
//            (granted, error) in
//            guard granted else { return }
//            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
//            }
//        }
//    }
}


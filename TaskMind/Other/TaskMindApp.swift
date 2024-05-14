//
//  TaskMindApp.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-01.
//

import SwiftUI
import FirebaseCore
import UserNotifications

@main
struct TaskMindApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetBadge), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    
    @objc func resetBadge() {
        UNUserNotificationCenter.current().setBadgeCount(0) { error in
                    if let error = error {
                        print("Error resetting badge: \(error.localizedDescription)")
                    } else {
                        print("Badge successfully reset")
                    }
                }
            }
}

//import SwiftUI
//import FirebaseCore
//
//@main
//struct TaskMindApp: App {
//    init() {
//        FirebaseApp.configure()
//    }
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

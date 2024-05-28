//
//  MyLocalNotification.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-14.
//

import Foundation
import UserNotifications

public class MyLocalNotification {
    
    func scheduleLocalNotification(for item: ToDoListItem) {
        
        let content = UNMutableNotificationContent()
        content.title = "TaskMinder"
        content.body = "Don't forget task: \(item.title) is due!"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let dueDate = Date(timeIntervalSince1970: item.dueDate)
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: item.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    UNUserNotificationCenter.current().add(request) { error in
                        if let error = error {
                            print("Error scheduling local notification: \(error.localizedDescription)")
                        } else {
                            print("Local notification scheduled successfully")
                        }
                    }
                } else {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                        if granted {
                            UNUserNotificationCenter.current().add(request) { error in
                                if let error = error {
                                    print("Error scheduling local notification: \(error.localizedDescription)")
                                } else {
                                    print("Local notification scheduled successfully")
                                }
                            }
                        } else if let error = error {
                            print("Error requesting notification authorization: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}

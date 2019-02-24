//
//  NotificationAngel.swift
//  Abomate
//
//  Created by Laureen Schausberger on 01.02.17.
//  Copyright © 2017 Manuel Leibetseder. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class NotificationAngel {
   
    /**
     Adds LocalNotificationRequest to Notification Center
     can be used to update too, if to-be-updated notification identifier is given
     otherwise identifier should be nil
     */
    public static func createNewNotification(at date: DateComponents) {
        
        let content    = UNMutableNotificationContent()
        content.title  = "REMINDER"
        
        content.subtitle = "Hey Buddy!"
        content.body     = "You told me to remind you on something special. Maybe you should have a look at your notes!"
        
        content.categoryIdentifier  = "message"
        
        let request = UNNotificationRequest(
            identifier: "123456789", content: content,
            trigger: self.createLocalNotificationTriggerByDate(date: date)
        )
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
    
    /**
     Creates a new LocalNotification-Trigger by time and date
     */
    private static func createLocalNotificationTriggerByDate(date: DateComponents) -> UNCalendarNotificationTrigger {
        return UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
    }
    
    /**
     Deletes Notification by its id
     */
    public static func deleteLocalNotification() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification: UNNotificationRequest in notificationRequests {
                if notification.identifier == "123456789" {
                    identifiers.append(notification.identifier)
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
    
}

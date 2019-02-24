//
//  NotificationDelegate.swift
//  Abomate
//
//  Created by Laureen Schausberger on 05.01.17.
//  Copyright © 2017 Manuel Leibetseder. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class NotificationDevil: NSObject, UNUserNotificationCenterDelegate {

    static let shared = NotificationDevil()
    
    override init() {}
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Play sound and show alert to the user
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "OK":
            print("Pressed ok")
        default:
            print("Unknown action")
        }
        completionHandler()
    }
}

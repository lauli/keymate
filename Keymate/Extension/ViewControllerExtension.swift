//
//  ViewControllerExtension.swift
//  Keymate
//
//  Created by Laureen Schausberger on 05.03.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import PermissionScope

extension SettingsViewController {
    
    func askForPermission() {
        var pscope: PermissionScope = PermissionScope(backgroundTapCancels: false)
        
        pscope.addPermission(NotificationsPermission(), message: "Keymate needs the permission to send you Notifications!")
        pscope = setPermissionStyles(pscope: pscope)
        
        pscope.show({ _, results in
            print("got results \(results)")
        }, cancelled: { (results) -> Void in
            print("cancelled")
        })
    }
    
    func setPermissionStyles(pscope: PermissionScope) -> PermissionScope {
        pscope.closeButtonTextColor         = UIColor.orange
        pscope.permissionButtonTextColor    = UIColor.orange
        pscope.permissionButtonBorderColor  = UIColor.orange
        pscope.authorizedButtonColor        = UIColor.black
        pscope.unauthorizedButtonColor      = UIColor.red
        return pscope
    }
    
    func doWeHavePermission() -> Bool {
        var permissions: Bool = true
        
        switch PermissionScope().statusNotifications() {
        case .disabled, .unauthorized, .unknown:
            permissions = false
        default: break
        }
        return permissions
    }
}

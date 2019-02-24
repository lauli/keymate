//
//  NSDate.swift
//  Keymate
//
//  Created by Laureen Schausberger on 05.03.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import Foundation

extension NSDate {
    /**
     Returns DateComponents of NSDate with year, month, day, hours, minute, second
     */
    public func dateComponents() -> DateComponents {
        return NSCalendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self as Date)
    }
}

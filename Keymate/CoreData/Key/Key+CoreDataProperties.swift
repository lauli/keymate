//
//  Key+CoreDataProperties.swift
//  Keymate
//
//  Created by Laureen Schausberger on 03.03.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import Foundation
import CoreData


extension Key {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Key> {
        return NSFetchRequest<Key>(entityName: "Key");
    }

    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var category: String?
    @NSManaged public var fav: Bool

}

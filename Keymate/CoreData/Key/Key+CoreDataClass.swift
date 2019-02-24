//
//  Key+CoreDataClass.swift
//  Keymate
//
//  Created by Laureen Schausberger on 03.03.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import Foundation
import CoreData

@objc(Key)
public class Key: ManagedObject {
    
    convenience init(context: NSManagedObjectContext) {
        let entity: NSEntityDescription = NSEntityDescription.entity(
            forEntityName: Key.entityName,
            in: context
            )!
        
        self.init(entity: entity, insertInto: context)
    }

    static func delete(key: Key, in context: NSManagedObjectContext) -> Bool {
        context.delete(key)
        return context.saveOrRollback()
    }
}

extension Key: ManagedObjectType {
    
    enum SortDescriptors: String {
        case abc = "abc"
    }
    
    public static var entityName: String {
        return "Key"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: SortDescriptors.abc.rawValue, ascending: false)]
    }
}

extension NSManagedObjectContext {
    
    public func saveOrRollback() -> Bool {
        do {
            try save()
            NotificationCenter.default.post(name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
            return true
        } catch let error as NSError {
            NSLog("Unresolved error \(error), [\(error.userInfo)]")
            
            rollback()
            return false
        }
    }
    
}

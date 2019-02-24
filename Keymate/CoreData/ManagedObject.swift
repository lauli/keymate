//
//  ManagedObjectType.swift
//  Keymate
//
//  Created by Laureen Schausberger on 01.03.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import Foundation
import CoreData
import UIKit

open class ManagedObject: NSManagedObject {
    /* lazy final var cdManager: CoreDataManager = {
     return (UIApplication.shared.delegate as! AppDelegate).cdManager
     } ()
     */
}

public protocol ManagedObjectType: class {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
    //static var defaultPredicate: NSPredicate { get }
}

public protocol DefaultManagedObjectType: ManagedObjectType {}

extension DefaultManagedObjectType {
    public static var defaultPredicate: NSPredicate { return NSPredicate(value: true) }
}

extension ManagedObjectType {
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
}

extension ManagedObjectType where Self: ManagedObject {
    
    public static func fetchInContext(_ context: NSManagedObjectContext, configurationBlock: (NSFetchRequest<NSFetchRequestResult>) -> Void = { _ in }) -> [Self] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Self.entityName)
        configurationBlock(request)
        guard let result = try! context.fetch(request) as? [Self] else { fatalError("Fetched objects have wrong type") }
        return result
    }

    public static func fetchInContext(_ context: NSManagedObjectContext, with predicate: NSPredicate?, configurationBlock: (NSFetchRequest<NSFetchRequestResult>) -> Void = { _ in }) -> [Self] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Self.entityName)

        if let pred = predicate {
            request.predicate = pred
        }

        configurationBlock(request)
        guard let result = try! context.fetch(request) as? [Self] else { fatalError("Fetched objects have wrong type") }
        return result
    }
    
    public static func sortedFetchRequest(_ predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> NSFetchRequest<NSFetchRequestResult> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        request.sortDescriptors = sortDescriptors
        request.predicate       = predicate
        
        return request
    }
}

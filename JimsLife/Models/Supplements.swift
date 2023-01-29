//
//  Supplements.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 28.01.23.
//

import Foundation
import CoreData

extension DoneSupplements {
    static func removeObject(object: DoneSupplements,from context: NSManagedObjectContext)
    {
        context.delete(object)
        
        do {
            try context.save()
        } catch {
            // handle error
        }
    }
    
    static func addObject(objectToAdd: LinkedSupplements,from context: NSManagedObjectContext) {
        let newItem = DoneSupplements(context: context)
        
        newItem.id = UUID()
        newItem.created_on = Date.now
        newItem.expires = Date.now.endOfDay
        
        newItem.linkedsupplements = objectToAdd
        newItem.supplements = objectToAdd.supplements

        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func containsSupplement(object: Supplements,from context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<DoneSupplements> = DoneSupplements.fetchRequest()
        request.predicate = NSPredicate(format: "supplements != nil", object)
        //request.predicate = NSPredicate(format: "supplements == %@", object)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking if object exists in entity store: \(error)")
            return false
        }
    }
    
    static var fetchAllDoneSupplements: NSFetchRequest<DoneSupplements> {
        let request: NSFetchRequest<DoneSupplements> = DoneSupplements.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DoneSupplements.created_on, ascending: true)]
        request.includesSubentities = true
        return request
    }
}

extension TodoSupplements {
    static func removeObject(object: TodoSupplements,from context: NSManagedObjectContext)
    {
        context.delete(object)
        
        do {
            try context.save()
        } catch {
            // handle error
        }
    }
    
    static func addObject(objectToAdd: LinkedSupplements,from context: NSManagedObjectContext) {
        let newItem = TodoSupplements(context: context)
        let calendar = Calendar.current
        
        newItem.id = UUID()
        newItem.created_on = Date.now
        newItem.expires = Date.now.endOfDay
        newItem.quantity_left = objectToAdd.quantity_per_period
        
        newItem.linkedsupplements = objectToAdd
        newItem.supplements = objectToAdd.supplements

        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func containsSupplement(object: Supplements, from context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<TodoSupplements> = TodoSupplements.fetchRequest()
        request.predicate = NSPredicate(format: "supplements != nil", object)
        //request.predicate = NSPredicate(format: "supplements == %@", object)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking if object exists in entity store: \(error)")
            return false
        }
    }
}

extension LinkedSupplements {
    static func removeObject(object: LinkedSupplements,from context: NSManagedObjectContext)
    {
        context.delete(object)
        
        do {
            try context.save()
        } catch {
            // handle error
        }
    }
    
    static func containsSupplement(object: Supplements,from context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<LinkedSupplements> = LinkedSupplements.fetchRequest()
        request.predicate = NSPredicate(format: "supplements != nil", object)
        //request.predicate = NSPredicate(format: "supplements == %@", object)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking if object exists in entity store: \(error)")
            return false
        }
    }
}

//
//  Supplements.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 28.01.23.
//

import Foundation
import CoreData
import CloudKit

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
        request.predicate = NSPredicate(format: "supplements == %@", object)
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

extension SkippedSupplements {
    static func removeObject(object: SkippedSupplements,from context: NSManagedObjectContext)
    {
        context.delete(object)
        
        do {
            try context.save()
        } catch {
            // handle error
        }
    }
    
    static func addObject(objectToAdd: LinkedSupplements,from context: NSManagedObjectContext) {
        let newItem = SkippedSupplements(context: context)
        
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
        let request: NSFetchRequest<SkippedSupplements> = SkippedSupplements.fetchRequest()
        request.predicate = NSPredicate(format: "supplements == %@", object)
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
        request.predicate = NSPredicate(format: "supplements == %@", object)
        //request.predicate = NSPredicate(format: "supplements == %@", object)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking if object exists in entity store: \(error)")
            return false
        }
    }
    
    func setQuantityLeft(quantityLeft: Int64){
        self.quantity_left = quantityLeft
        
        do {
            try self.managedObjectContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension LinkedSupplements {
    static func removeObject(object: LinkedSupplements,from context: NSManagedObjectContext) -> (success: Bool, errorMessage: String?)
    {
        context.delete(object)
        
        do {
            try context.save()
            return (success: true, errorMessage: nil)
        } catch {
            print("Error validating delete: \(error)")
            return (success: false, errorMessage: error.localizedDescription)
        }
    }
    
    static func addObject(objectToAdd: Supplements,period_days: Int64,quantity_per_period: Int64,from context: NSManagedObjectContext) -> (success: Bool, errorMessage: String?) {
        let newItem = LinkedSupplements(context: context)
        
        newItem.id = UUID()
        newItem.period_days = period_days
        newItem.quantity_per_period = quantity_per_period
        
        do {
            try newItem.validateForInsert()
            newItem.supplements = objectToAdd
        } catch {
            print("Error validating insert: \(error)")
            context.delete(newItem)
            return (success: false, errorMessage: error.localizedDescription)
        }
        
        do {
            try newItem.validateForInsert()
            try context.save()
            return (success: true, errorMessage: nil)
        } catch {
            print("Error while inserting: \(error)")
            context.delete(newItem)
            return (success: false, errorMessage: error.localizedDescription)
        }
    }
    
    static func containsSupplement(object: Supplements,from context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<LinkedSupplements> = LinkedSupplements.fetchRequest()
        request.predicate = NSPredicate(format: "supplements == %@", object)
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

extension Supplements {
    static func fetchDataFromCloudKit(completion: @escaping ([CKRecord]?) -> Void) {
        let container = CKContainer.default()
        let publicDB = container.publicCloudDatabase
        let query = CKQuery(recordType: "CD_Supplements", predicate: NSPredicate(value: true))
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
          if let error = error {
            print("Error fetching data from CloudKit: \(error)")
            completion(nil)
            return
          }
          
          guard let records = records else {
            completion(nil)
            return
          }
          
          completion(records)
        }
      }
    
    static func recordExists(supplementId: String, from context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<Supplements> = Supplements.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Supplements.id, ascending: true)]
        request.predicate = NSPredicate(format: "id == %@", supplementId as CVarArg)
        
        do {
            let count = try context.count(for: request)
            
            return count > 0
        } catch {
            print("Error checking if object exists in entity store: \(error)")
            return false
        }
    }
    
    static func getSupplementWithId(withID id: String, context: NSManagedObjectContext) -> Supplements {
        let request: NSFetchRequest<Supplements> = Supplements.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let result = try context.fetch(request)
            return result[0]
        } catch {
            print("Error checking if object exists: \(error)")
            return Supplements()
        }
    }
    
    static func isSupplementUpToDate(ckRecord: CKRecord, supplement: Supplements) -> Bool {
        // Get all the attributes of the `Supplements` entity
        let attributes = supplement.entity.attributesByName.keys
        
        // Check if the values of each attribute in the `CKRecord` match the corresponding attribute value in the `Supplements` object
        for attribute in attributes {
            if(attribute != "id")
            {
                guard let ckRecordValue = ckRecord["CD_"+attribute] as? NSObject else { return false }
                guard let supplementValue = supplement.value(forKey: attribute) as? NSObject else { return false }
                
                if !ckRecordValue.isEqual(supplementValue) {
                    return false
                }
            }
        }
        
        return true
    }
    
    static func addObject(objectToAdd: Supplements,from context: NSManagedObjectContext) {
        let newItem = Supplements(context: context)
        newItem.id = objectToAdd.id
        newItem.name = objectToAdd.name
        newItem.itemDescription = objectToAdd.itemDescription
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func createObjectWithRecord(record: CKRecord,from context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Supplements", in: context)!
        let managedObject = NSManagedObject(entity: entity, insertInto: context)

        // Map the properties from the CKRecord to the managed object
        for key in record.allKeys() {
          let value = record[key]
          
            // Remove the "CD_" prefix from the key
            let newKey = key.replacingOccurrences(of: "CD_", with: "")
            
          switch value {
            case let value as CKRecordValue:
              if newKey == "id" {
                                if let stringValue = value as? String {
                                    if let uuid = UUID(uuidString: stringValue) {
                                        managedObject.setValue(uuid, forKey: newKey)
                                    } else {
                                        print("Invalid UUID string: \(stringValue)")
                                    }
                                }
                            } else {
                                managedObject.setValue(value, forKey: newKey)
                            }
            default:
              break
          }
        }
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func updateObjectWithRecord(record: CKRecord,from context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Supplements", in: context)!
        let supplement = Supplements.getSupplementWithId(withID: record.value(forKey: "CD_id") as! String, context: context)

        // Map the properties from the CKRecord to the managed object
        for key in record.allKeys() {
            let value = record[key]
            // Remove the "CD_" prefix from the key
            let newKey = key.replacingOccurrences(of: "CD_", with: "")
            
          switch value {
            case let value as CKRecordValue:
              if(newKey != "id")
              {
                  supplement.setValue(value, forKey: newKey)
              }
            default:
              break
          }
        }
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func containsSupplement(withID id: UUID, context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<Supplements> = Supplements.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let result = try context.fetch(request)
            return result.count > 0
        } catch {
            print("Error checking if object exists: \(error)")
            return false
        }
    }
}

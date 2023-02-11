//
//  Persistence.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 13.01.23.
//

import CoreData
import CloudKit

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Supplements")
        
        let defaultDesctiption = container.persistentStoreDescriptions.first
        let url = defaultDesctiption?.url?.deletingLastPathComponent()
                
        let privateDescription = NSPersistentStoreDescription(url: url!.appendingPathComponent("private.sqlite"))
        let privateOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.dev.schnettler.JimsLife")
        privateOptions.databaseScope = .private
        privateDescription.cloudKitContainerOptions = privateOptions
        privateDescription.configuration = "Private"
        privateDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        privateDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
                
        let publicDescription = NSPersistentStoreDescription(url: url!.appendingPathComponent("public.sqlite"))
        let publicOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.dev.schnettler.JimsLife")
        publicOptions.databaseScope = .public
        publicDescription.cloudKitContainerOptions = publicOptions
        publicDescription.configuration = "Public"
        publicDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        publicDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
                
        container.persistentStoreDescriptions = [privateDescription]
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        //container.viewContext.automaticallyMergesChangesFromParent = true
        
        //Upload scheme to CloudKit
        //do {
           //try container.initializeCloudKitSchema(options: NSPersistentCloudKitContainerSchemaInitializationOptions())
        //} catch {
        //print(error)
            
        //}
    }
}

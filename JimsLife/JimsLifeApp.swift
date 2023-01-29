//
//  JimsLifeApp.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 07.04.21.
//

import SwiftUI


class AppDelegate: NSObject, UIApplicationDelegate {
  
}

@main
struct JimsLifeApp: App {
    let persistenceController = PersistenceController.shared
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @Environment(\.managedObjectContext) private var viewContext
    
    //linked supplements are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \LinkedSupplements.id, ascending: true)],
        animation: .easeIn)
    private var linkedSupplementItems: FetchedResults<LinkedSupplements>
    
    //todo supplemtns are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoSupplements.quantity_left, ascending: false)],
        animation: .easeIn)
    private var todoSupplementItems: FetchedResults<TodoSupplements>
    
    //done supplements are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DoneSupplements.created_on, ascending: false)],
        animation: .easeIn)
    private var doneSupplementItems: FetchedResults<DoneSupplements>
    
    private func configureStoresOnStart(){
        //todo supplements which are expired are removed from the store
        for item in todoSupplementItems{
            if(item.expires! <= Date.now)
            {
                TodoSupplements.removeObject(object: item, from: viewContext)
            }
        }
        
        //done supplements which are expired are removed from the store
        for item in doneSupplementItems{
            if(item.expires! <= Date.now)
            {
                DoneSupplements.removeObject(object: item, from: viewContext)
            }
        }
        
        //loop over linkedSupplements to check if there is an object of it in todoSupplements or doneSupplements
        for item in linkedSupplementItems{
            if(!TodoSupplements.containsSupplement(object: item.supplements!, from: viewContext) && DoneSupplements.containsSupplement(object: item.supplements!, from: viewContext))
            {
                //if there doesnt exists the linkedSupplement in Todo or done the there must be created a new one in todo
                TodoSupplements.addObject(objectToAdd: item, from: viewContext)
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(){
                   configureStoresOnStart()
                }
        }
    }
}

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

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(){
                   
                }
        }
    }
}

//
//  SettingsView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 02.07.22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView{
            HStack(alignment: .top){
                VStack{
                    List{
                        Section(header: Text("active supplements:")){
                            Text("Aktives Supplement 1")
                            Text("Aktives Supplement 2")
                            
                        }
                        Section(header: Text("more possible supplements:")){
                            Text("Mögliches Supplement 1")
                            Text("Mögliches Supplement 2")
                        }
                    }
                }
            }
            Spacer()
        }.navigationTitle("my supplements")
        
    }
    
    private func addLinkedSupplement(objectToAdd: Supplements, periodDays: Int64, quantity_per_period: Int64) {
        withAnimation {
            let newItem = LinkedSupplements(context: viewContext)
            newItem.quantity_per_period = Int64()
            newItem.period_days = Int64()
            newItem.supplements = objectToAdd
            
            //newItem.supplements?.categorie = objectToAdd.supplements?.categorie
            //newItem.supplements?.imageName = objectToAdd.supplements?.imageName
            //newItem.supplements?.itemDescription = objectToAdd.supplements?.itemDescription
            //newItem.supplements?.name = objectToAdd.supplements?.name

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteLinkedSupplement(deleteObject: LinkedSupplements) {
        withAnimation {
            viewContext.delete(deleteObject)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

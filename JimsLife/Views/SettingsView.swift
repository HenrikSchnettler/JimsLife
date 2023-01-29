//
//  SettingsView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 02.07.22.
//

import SwiftUI

struct SettingsView: View {
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
    
    //all supplements are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Supplements.name, ascending: true)],
        predicate: NSPredicate(format: "linkedsupplements == nil"),
        animation: .easeIn)
    private var allSupplementsItems: FetchedResults<Supplements>
    
    @State private var showAddSupplementAlert = false
    var body: some View {
        NavigationView{
            HStack(alignment: .top){
                VStack{
                    List{
                        Section(header: Text("active supplements:")){
                            ForEach(linkedSupplementItems) { item in
                                HStack{
                                    Text(item.supplements?.name ?? "")
                                    Spacer()
                                    Button(action: {
                                        LinkedSupplements.removeObject(object: item, from: viewContext)
                                    }) {
                                        Image(systemName: "minus")
                                            .foregroundColor(.red)
                                    }

                                }
                            }
                        }
                        Section(header: Text("more possible supplements:")){
                            ForEach(allSupplementsItems) { item in
                                HStack{
                                    Text(item.name ?? "")
                                    Spacer()
                                    Button(action: {
                                        showAddSupplementAlert = true
                                    })
                                    {
                                        Image(systemName: "plus")
                                            .foregroundColor(.green)
                                    }
                                    .alert("add supplement", isPresented: $showAddSupplementAlert, actions: {
                                        
                                    }, message: {
                                        Text("please enter the period lenght and quantity of supplements you want to take per period")
                                    })

                                }
                            }
                        }
                    }
                }
            }
            Spacer()
        }.navigationTitle("my supplements")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

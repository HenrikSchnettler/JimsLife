//
//  SettingsView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 02.07.22.
//

import SwiftUI
import Combine

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
    
    //all supplements are fetched which currently arent linked to the user
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Supplements.name, ascending: true)],
        predicate: NSPredicate(format: "linkedsupplements == nil"),
        animation: .easeIn)
    private var allSupplementsItems: FetchedResults<Supplements>
    
    @State private var showAddSupplementAlert = false
    @State private var showDeleteSupplementConfirm = false
    @State private var showErrorAlert = false
    
    @State var period_days: String = ""
    @State var quantity_per_period: String = ""
    @State var activeLinkedSupplementItem = LinkedSupplements()
    @State var activeUnlinkedSupplement = Supplements()
    
    @StateObject var errorHandlerObj = ErrorHandler()
     
    var body: some View {
        NavigationView{
            HStack(alignment: .top){
                VStack{
                    List{
                        Section(header: Text("active supplements:")){
                            ForEach(linkedSupplementItems) { item in
                                HStack{
                                    Circle()
                                        .fill(Color.ContentOverAccent)
                                        .frame(minWidth: 25, maxWidth: 40, minHeight: 25, maxHeight: 40)
                                        .overlay(
                                            Text(item.supplements!.name!.prefix(2).uppercased())
                                                .foregroundColor(Color.InvertedContentOverAccent )
                                                .frame(width: 40, height: 40)
                                                
                                        )
                                    Text(item.supplements?.name ?? "")
                                    Spacer()
                                    Button(action: {
                                        self.showDeleteSupplementConfirm = true
                                        self.activeLinkedSupplementItem = item
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(minWidth: 25, maxWidth: 40, minHeight: 25, maxHeight: 40)
                                }
                            }
                        }
                        Section(header: Text("more possible supplements:")){
                            ForEach(allSupplementsItems) { item in
                                
                                HStack{
                                    Circle()
                                        .fill(Color.ContentOverAccent)
                                        .frame(minWidth: 25, maxWidth: 40, minHeight: 25, maxHeight: 40)
                                        .overlay(
                                            Text(item.name!.prefix(2).uppercased())
                                                .foregroundColor(Color.InvertedContentOverAccent )
                                                .frame(width: 40, height: 40)
                                                
                                        )
                                    Text(item.name ?? "")
                                    Spacer()
                                    Button(action: {
                                        self.showAddSupplementAlert = true
                                        self.period_days = ""
                                        self.quantity_per_period = ""
                                        self.activeUnlinkedSupplement = item
                                    })
                                    {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.green)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(minWidth: 25, maxWidth: 40, minHeight: 25, maxHeight: 40)
                                }
                            }
                        }
                    }
                    .confirmationDialog("Are you sure?",
                                        isPresented: self.$showDeleteSupplementConfirm) {
                         Button("Deactivate supplement?", role: .destructive) {
                             let (success, errorMessage) = LinkedSupplements.removeObject(object: activeLinkedSupplementItem, from: viewContext)
                             
                             if success {
                                 // The supplement was successfully removed
                             } else {
                                 // The supplement couldnt be removed
                                 errorHandlerObj.selectError(ErrorCase: ErrorHandler.Error.removeSupplementValidation)
                             }
                             showDeleteSupplementConfirm = false
                         }
                    }
                    .alert("add supplement", isPresented: self.$showAddSupplementAlert, actions: {
                        TextField("period lenght (in days)", text: self.$period_days)
                            .keyboardType(.numberPad)

                                            
                        TextField("quantity", text: self.$quantity_per_period)
                            .keyboardType(.numberPad)

                                                    
                        Button("add supplement", action: {
                            let (success, errorMessage) = LinkedSupplements.addObject(objectToAdd: activeUnlinkedSupplement, period_days: Int64(period_days) ?? 1, quantity_per_period: Int64(quantity_per_period) ?? 1, from: viewContext)
                                                
                                    if success {
                                        // The supplement was successfully added
                                    } else {
                                                    
                                        // The supplement couldnt be added
                                        errorHandlerObj.selectError(ErrorCase: ErrorHandler.Error.linkSupplementValidation)
                                    }
                                })
                                                                                    
                                Button("cancel", role: .cancel, action: {
                                    showAddSupplementAlert = false
                                })
                            }, message: {
                                Text("please enter the period lenght and quantity of supplements you want to take per period")
                        })
                }
            }
            Spacer()
        }.navigationTitle("my supplements")
            .errorAlert(error: $errorHandlerObj.error)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

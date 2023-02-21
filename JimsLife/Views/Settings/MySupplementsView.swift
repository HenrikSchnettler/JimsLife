//
//  SettingsView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 02.07.22.
//

import SwiftUI
import Combine

struct MySupplementsView: View {
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
    
    //bind for the quick alert to add a supplement
    @State private var showAddSupplementAlert = false
    //bind for the confirm dialog to remove a supplement
    @State private var showDeleteSupplementConfirm = false
    //bind to show a error alert
    @State private var showErrorAlert = false
    
    //bind for the input of the interval lenght for the to link supplement
    @State private var period_days: String = ""
    //bind for the input of the quantity to take per interval
    @State private var quantity_per_period: String = ""
    //bind which linked supplement is currently active after action on it is performed
    @State private var activeLinkedSupplementItem = LinkedSupplements()
    //bind which unlinked supplement is currently active after action on it is performed
    @State private var activeUnlinkedSupplement = Supplements()
    //bind which supplement should be displayed in the supplementInfo View (Sheet)
    @State private var activeSupplement: Supplements?
    
    //bind the errorHandler Obj is imported
    @StateObject private var errorHandlerObj = ErrorHandler()
     
    var body: some View {
        NavigationView{
            HStack(alignment: .top){
                VStack{
                    List{
                        Section(header: Text("active supplements:")){
                            ForEach(linkedSupplementItems) { item in
                                HStack{
                                    //picture, name and spacer are a button which triggers a sheet which contains information about the supplement
                                    Button(action: {
                                        //the binding variable is set to the clicked item which automatically triggers the sheet
                                        activeSupplement = item.supplements
                                    }) {
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
                                        }
                                    }
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
                                    //picture, name and spacer are a button which triggers a sheet which contains information about the supplement
                                    Button(action: {
                                        //the binding variable is set to the clicked item which automatically triggers the sheet
                                        activeSupplement = item
                                    }) {
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
                                        }
                                    }
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
                .sheet(item: $activeSupplement, onDismiss: {
                    activeSupplement = nil
                }) { item in
                    
                        SupplementInfoView(context: viewContext, supplement: item)
                            .onTapGesture {
                                activeSupplement = nil
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("my supplements")
            .errorAlert(error: $errorHandlerObj.error)
        }
    }

struct MySupplementsView_Previews: PreviewProvider {
    static var previews: some View {
        MySupplementsView()
    }
}
